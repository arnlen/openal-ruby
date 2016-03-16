Gem::Specification.new {|gem|
    gem.name            = 'openal'
    gem.version         = '0.1.0'
    gem.date            = '2016-03-16'
    gem.summary         = 'OpenAL SOFT wrapper for Ruby with EFX/EXT support'
    gem.description     = 'A lightweight FFI wrapper around OpenAL SOFT for use in Ruby.  It is built against ' +
                          'MRI 2.3.0 and should have cross-platform functionality with most other major Rubys.'
    gem.authors         = ['npomf']
    gem.email           = ''
    gem.homepage        = 'https://github.com/npomf/openal-ruby'
    gem.license         = 'MIT'
    gem.files           = [
                            'lib/al.rb',
                            'lib/alc.rb',
                            'lib/efx.rb',
                            'lib/ext.rb'
                          ]
}
