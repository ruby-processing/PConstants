# PConstants

Exploring using processing [PConstants][pconstants] with JRuby, here is simple project that could help you to understand [propane][propane] and [JRubyArt][jruby_art].

Here only compile the PConstants.java (it has no external dependencies)

### Use simplicity of a custom Rakefile
```
rake
```

### Or Use polyglot maven directly to create a java library
Read more about [polyglot maven here][polyglot]

```bash
mvn package
```

### The use ruby minitest to test and explore PConstants
```
cd test
jruby has_constants_test.rb
```

What we confirm in the test that under JRuby `PConstants` is seen as a ruby module, and we only need to include the module to implement the interface. But it could have possible namespace issues.

[pconstants]
[propane]:https://github.com/ruby-processing/propane
[jruby_art]:https://ruby-processing.github.io/JRubyArt/
[polyglot]:https://github.com/takari/polyglot-maven
