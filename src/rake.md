---
title: Rake
category: Ruby
tags: [Featured]
updated: 2018-12-18
columns: 2
description: Rake
---
### Basic syntax

```ruby
namespace :foo do
  desc "Description"
  task :bar do
    ...
  end

  task :baz => :dependency do
  end

  task :baz => [:dep1, :dep2, :dep3] do
  end
end

 # rake foo:bar
```

### Rake task with arguments

```ruby
desc "Do something"
task :workit, [:id] => :environment do |_, args|
  id = args[:id]
end

 # rake workit[234]
```