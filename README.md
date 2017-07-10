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
```bash
cd test
jruby has_constants_test.rb
```

What we confirm in the test that under JRuby `PConstants` is seen as a ruby module, and we only need to include the module to implement the interface. But it could have possible namespace issues.

### To experiment with different type of java constants

```bash
git checkout final_class # for PConstants as a final class (better practice than using an interface, but still frowned on)
# or
git checkout enum # Where there are enum version of seleceted PConstants (the use of global enum is also considered non-ideal)
# or for alternative means of accessing enums using :constant_missing, makes no sens to me
git checkout constant_missing # does not seem to me to have any advantages over include module method

[pconstants]:https://github.com/processing/processing/blob/master/core/src/processing/core/PConstants.java
[propane]:https://ruby-processing.github.io/propane/
[jruby_art]:https://ruby-processing.github.io/JRubyArt/
[polyglot]:https://github.com/takari/polyglot-maven
