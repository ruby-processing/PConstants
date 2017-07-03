project 'pconstants' do

  model_version '4.0.0'
  id 'processing:core:1.0-SNAPSHOT'
  packaging 'jar'

  description 'pconstants jar'

  developer 'monkstone' do
    name 'Martin Prout'
    roles 'developer'
  end

  properties( 'maven.compiler.source' => '1.8',
              'project.build.sourceEncoding' => 'UTF-8',
              'polyglot.dump.pom' => 'pom.xml',
              'pconstants.basedir' => '${project.basedir}',
              'maven.compiler.target' => '1.8' )

  overrides do
    plugin( :jar, '2.3.2',
            'outputDirectory' =>  '${pconstants.basedir}/lib' )
  end

  build do
    default_goal 'package'
    source_directory 'src'
    final_name 'pconstants'
  end
end
