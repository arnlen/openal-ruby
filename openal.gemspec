Gem::Specification.new {|gem|
    gem.name            = 'openal-soft'
    gem.version         = '0.1.4'
    gem.date            = '2016-03-25'
    gem.summary         = 'OpenAL SOFT wrapper for Ruby with EFX/EXT support'
    gem.description     = 'A lightweight FFI wrapper around OpenAL SOFT for use in Ruby.  It is built against ' +
                          'MRI 2.3.0 and should have cross-platform functionality with most other major Rubys.'
    gem.authors         = ['npomf']
    gem.add_runtime_dependency 'ffi', '~> 1.9', '>= 1.9.0'
    gem.requirements    << 'OpenAL drivers or OpenAL SOFT'
    gem.email           = ''
    gem.homepage        = 'https://github.com/npomf/openal-ruby'
    gem.license         = 'MIT'
    gem.files           = [
                            'lib/al.rb',
                            'lib/alc.rb',
                            'lib/efx.rb',
                            'lib/ext.rb',
                            'lib/al/listener.rb',
                            'lib/efx/equalizer.rb',
                            'lib/efx/reverb.rb',
                            'lib/util/pointers.rb'
                          ]
}
