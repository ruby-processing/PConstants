---
layout: post
title:  "1st Steps"
date:   2017-07-03 07:34:13
categories: pconstants update
---

### Requirements

Requires JRuby

### Install the ruby_wordcram gem

```bash
jruby -S gem install ruby_wordcram # safe way
gem install ruby_wordcram # using rvm rbenv to use jruby instead of MRI
```

Create basic sketch

`mkdir data` and install fonts see below

```ruby
# This sketch shows how to make a WordCram from any webpage.
# It uses my blog
# Minya Nouvelle font available at http://www.1001fonts.com/font_details.html?font_id=59

require 'ruby_wordcram'

def settings
  size 800, 400
end

def setup
  sketch_title 'WordCram from Web Page'
  color_mode(HSB)
  background(255)
  WordCram.new(self)
          .from_web_page('https://ruby-processing.github.io/about/')
          .with_font(create_font(data_path('MINYN___.TTF'), 1))
          .with_colorer(Colorers.two_hues_random_sats_on_white(self))
          .sized_by_weight(7, 100)
          .draw_all
end
```

### Output

<img src="{{ site.github.url }}/assets/wordcram.png" />
Follow links for more JRubyArt [examples][examples] or [propane examples][propane examples].

Usage with propane is essentially the same but with a class wrapper.

[examples]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/external_library/gem/ruby_wordcram/
[propane examples]:https://github.com/ruby-processing/propane-examples/tree/master/external_library/gem/ruby_wordcram
