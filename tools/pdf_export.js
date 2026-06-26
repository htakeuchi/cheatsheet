#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { pathToFileURL } = require('url');

let chromium;
try {
  ({ chromium } = require('playwright'));
} catch (error) {
  console.error('Playwright is not installed. Run `npm install` first.');
  process.exit(1);
}

const PAPER_SIZES = {
  A5: [148, 210],
  A4: [210, 297],
  A3: [297, 420],
  Letter: [215.9, 279.4],
  Legal: [215.9, 355.6]
};

function parseArgs(argv) {
  const options = {};
  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (!arg.startsWith('--')) {
      throw new Error(`Unexpected argument: ${arg}`);
    }
    const key = arg.slice(2);
    const next = argv[i + 1];
    if (!next || next.startsWith('--')) {
      options[key] = true;
    } else {
      options[key] = next;
      i += 1;
    }
  }
  return options;
}

function numberOption(value, fallback) {
  if (value === undefined || value === null || value === '') return fallback;
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
}

function normalizePaper(value) {
  const paper = value || 'A4';
  const match = Object.keys(PAPER_SIZES).find((key) => key.toLowerCase() === String(paper).toLowerCase());
  if (!match) {
    throw new Error(`Unsupported paper size: ${paper}. Supported: ${Object.keys(PAPER_SIZES).join(', ')}`);
  }
  return match;
}

function pageSize(paper, orientation) {
  const [shortSide, longSide] = PAPER_SIZES[paper];
  if (orientation === 'portrait') return [shortSide, longSide];
  if (orientation === 'landscape') return [longSide, shortSide];
  throw new Error(`Unsupported orientation: ${orientation}. Use portrait or landscape.`);
}

function chromeExecutablePath() {
  const candidates = [
    process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,
    '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    '/Applications/Chromium.app/Contents/MacOS/Chromium'
  ].filter(Boolean);

  return candidates.find((candidate) => fs.existsSync(candidate));
}

async function launchBrowser() {
  try {
    return await chromium.launch({ headless: true });
  } catch (error) {
    const executablePath = chromeExecutablePath();
    if (!executablePath) throw error;
    return chromium.launch({ headless: true, executablePath });
  }
}

async function metaContent(page, name) {
  return page.$eval(`meta[name="${name}"]`, (element) => element.content).catch(() => undefined);
}

function mmToPx(mm) {
  return Math.ceil((mm * 96) / 25.4);
}

function layoutStyle({ widthMm, heightMm, marginMm, columns, fontSizePt }) {
  const titleSize = Math.max(fontSizePt * 1.65, fontSizePt + 3);
  return `
    @page { size: ${widthMm}mm ${heightMm}mm; margin: 0; }
    :root {
      --page-width: ${widthMm}mm;
      --page-height: ${heightMm}mm;
      --page-margin: ${marginMm}mm;
      --columns: ${columns};
      --font-size: ${fontSizePt.toFixed(2)}pt;
      --title-size: ${titleSize.toFixed(2)}pt;
    }
  `;
}

async function applyLayout(page, layout) {
  await page.evaluate((css) => {
    let element = document.getElementById('pdf-fit-style');
    if (!element) {
      element = document.createElement('style');
      element.id = 'pdf-fit-style';
      document.head.appendChild(element);
    }
    element.textContent = css;
  }, layoutStyle(layout));
  await page.waitForTimeout(20);
}

async function measure(page) {
  return page.evaluate(() => {
    const pageElement = document.querySelector('.print-page');
    const sheet = document.querySelector('.print-sheet');
    if (!pageElement || !sheet) {
      throw new Error('Print template must include .print-page and .print-sheet elements.');
    }
    const tolerance = 1;
    const horizontalOverflow = sheet.scrollWidth - sheet.clientWidth;
    const verticalOverflow = sheet.scrollHeight - sheet.clientHeight;
    return {
      sheetClientWidth: sheet.clientWidth,
      sheetScrollWidth: sheet.scrollWidth,
      sheetClientHeight: sheet.clientHeight,
      sheetScrollHeight: sheet.scrollHeight,
      pageClientWidth: pageElement.clientWidth,
      pageClientHeight: pageElement.clientHeight,
      fits: horizontalOverflow <= tolerance && verticalOverflow <= tolerance,
      horizontalOverflow,
      verticalOverflow
    };
  });
}

function columnCandidates(requested, defaultColumns) {
  if (requested && requested !== 'auto') {
    const fixed = Number.parseInt(requested, 10);
    if (!Number.isInteger(fixed) || fixed < 1) throw new Error(`Invalid column count: ${requested}`);
    return [fixed];
  }

  const preferred = Number.parseInt(defaultColumns, 10);
  const candidates = new Set();
  if (Number.isInteger(preferred) && preferred > 0) candidates.add(preferred);
  [3, 4, 5, 2, 6, 1].forEach((value) => candidates.add(value));
  return Array.from(candidates).filter((value) => value >= 1 && value <= 6);
}

async function findBestLayout(page, baseOptions) {
  const step = 0.1;
  let best = null;
  let lastMeasurement = null;

  for (const columns of baseOptions.columnCandidates) {
    for (let fontSizePt = baseOptions.maxFontSizePt; fontSizePt >= baseOptions.minFontSizePt - 0.001; fontSizePt -= step) {
      const layout = { ...baseOptions, columns, fontSizePt };
      await applyLayout(page, layout);
      const result = await measure(page);
      lastMeasurement = { ...result, columns, fontSizePt };
      if (!result.fits) continue;

      if (
        !best ||
        fontSizePt > best.fontSizePt + 0.001 ||
        (Math.abs(fontSizePt - best.fontSizePt) < 0.001 && columns < best.columns)
      ) {
        best = { columns, fontSizePt, measurement: result };
      }
      break;
    }
  }

  return { best, lastMeasurement };
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  if (!args.input || !args.output) {
    throw new Error('Usage: node tools/pdf_export.js --input docs/print/flstudio.html --output docs/pdf/flstudio.pdf [--paper A4] [--orientation landscape]');
  }

  const inputPath = path.resolve(args.input);
  const outputPath = path.resolve(args.output);
  if (!fs.existsSync(inputPath)) throw new Error(`Input file does not exist: ${inputPath}`);

  const browser = await launchBrowser();
  const page = await browser.newPage();
  await page.goto(pathToFileURL(inputPath).href, { waitUntil: 'load' });
  await page.emulateMedia({ media: 'print' });

  const defaultColumns = await metaContent(page, 'cheatsheet-default-columns');
  const metaPaper = await metaContent(page, 'cheatsheet-pdf-paper');
  const metaOrientation = await metaContent(page, 'cheatsheet-pdf-orientation');
  const metaColumns = await metaContent(page, 'cheatsheet-pdf-columns');
  const metaMargin = await metaContent(page, 'cheatsheet-pdf-margin-mm');
  const metaMinFont = await metaContent(page, 'cheatsheet-pdf-min-font-size-pt');
  const metaMaxFont = await metaContent(page, 'cheatsheet-pdf-max-font-size-pt');

  const paper = normalizePaper(args.paper || metaPaper);
  const orientation = String(args.orientation || metaOrientation || 'landscape').toLowerCase();
  const [widthMm, heightMm] = pageSize(paper, orientation);
  const marginMm = numberOption(args['margin-mm'], numberOption(metaMargin, 3));
  const minFontSizePt = numberOption(args['min-font-size-pt'], numberOption(metaMinFont, 5.5));
  const maxFontSizePt = numberOption(args['max-font-size-pt'], numberOption(metaMaxFont, 8));
  const requestedColumns = args.columns || metaColumns || 'auto';

  if (minFontSizePt > maxFontSizePt) {
    throw new Error('min-font-size-pt must be smaller than or equal to max-font-size-pt.');
  }

  await page.setViewportSize({
    width: mmToPx(widthMm),
    height: mmToPx(heightMm)
  });

  const { best, lastMeasurement } = await findBestLayout(page, {
    widthMm,
    heightMm,
    marginMm,
    minFontSizePt,
    maxFontSizePt,
    columnCandidates: columnCandidates(requestedColumns, defaultColumns)
  });

  if (!best) {
    await browser.close();
    const details = lastMeasurement
      ? ` Last measurement: columns=${lastMeasurement.columns}, font=${lastMeasurement.fontSizePt.toFixed(1)}pt, horizontalOverflow=${lastMeasurement.horizontalOverflow.toFixed(1)}px, verticalOverflow=${lastMeasurement.verticalOverflow.toFixed(1)}px.`
      : '';
    throw new Error(`Content does not fit on one ${paper} ${orientation} page at ${minFontSizePt}pt or larger.${details}`);
  }

  await applyLayout(page, {
    widthMm,
    heightMm,
    marginMm,
    columns: best.columns,
    fontSizePt: best.fontSizePt
  });

  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  await page.pdf({
    path: outputPath,
    printBackground: true,
    preferCSSPageSize: true
  });
  await browser.close();

  console.log(`Generated ${outputPath}`);
  console.log(`Layout: ${paper} ${orientation}, columns=${best.columns}, font=${best.fontSizePt.toFixed(1)}pt, margin=${marginMm}mm`);
}

main().catch((error) => {
  console.error(error.message);
  process.exit(1);
});
