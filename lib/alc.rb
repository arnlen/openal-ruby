require 'ffi'

module ALC
    extend FFI::Library

    # handle initialization
    ffi_lib case RbConfig::CONFIG['host_os']
        when /mac\s?os|darwin/ix
            '/System/Library/Frameworks/OpenAL.framework/libAL.dylib'
        when /mswin|msys|mingw|cygwin|bcwin|wince|emc/ix
            if File.exists? 'C:/Windows/System32/soft_oal.dll'
                'C:/Windows/System32/soft_oal.dll'
            elsif File.exists? 'bin/soft_oal.dll'
                puts 'No system OpenAL Soft, but found local DLL; using that instead' if $DEBUG
                File.expand_path('bin') + '/soft_oal.dll'
            else
                warn 'No OpenAL Soft detected; falling back to default implementation'
                'C:/Windows/System32openal32.dll'
            end
        when /linux|unix|bsd/ix
            'libopenal.so'
    end

    ALC_FALSE                                = 0
    ALC_TRUE                                 = 1
    ALC_NO_ERROR                             = 0
    ALC_EXT_CAPTURE                          = 1
    ALC_ENUMERATE_ALL_EXT                    = 1
    ALC_FREQUENCY                            = 0x1007
    ALC_REFRESH                              = 0x1008
    ALC_SYNC                                 = 0x1009
    ALC_MONO_SOURCES                         = 0x1010
    ALC_STEREO_SOURCES                       = 0x1011
    ALC_INVALID_DEVICE                       = 0xA001
    ALC_INVALID_CONTEXT                      = 0xA002
    ALC_INVALID_ENUM                         = 0xA003
    ALC_INVALID_VALUE                        = 0xA004
    ALC_OUT_OF_MEMORY                        = 0xA005
    ALC_MAJOR_VERSION                        = 0x1000
    ALC_MINOR_VERSION                        = 0x1001
    ALC_ATTRIBUTES_SIZE                      = 0x1002
    ALC_ALL_ATTRIBUTES                       = 0x1003
    ALC_DEFAULT_DEVICE_SPECIFIER             = 0x1004
    ALC_DEVICE_SPECIFIER                     = 0x1005
    ALC_EXTENSIONS                           = 0x1006
    ALC_CAPTURE_DEVICE_SPECIFIER             = 0x0310
    ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER     = 0x0311
    ALC_CAPTURE_SAMPLES                      = 0x0312
    ALC_DEFAULT_ALL_DEVICES_SPECIFIER        = 0x1012
    ALC_ALL_DEVICES_SPECIFIER                = 0x1013

    # define types
    typedef :char,      :ALCboolean
    typedef :char,      :ALCchar
    typedef :char,      :ALCbyte
    typedef :uchar,     :ALCubyte
    typedef :short,     :ALCshort
    typedef :uint16,    :ALCushort
    typedef :int,       :ALCint
    typedef :uint,      :ALCuint
    typedef :int,       :ALCsizei
    typedef :int,       :ALCenum
    typedef :float,     :ALCfloat
    typedef :double,    :ALCdouble
    typedef :void,      :ALCvoid

    # declare entry-points
    attach_function :alcOpenDevice, [:pointer], :pointer
    attach_function :alcCreateContext, [:pointer, :pointer], :pointer
    attach_function :alcMakeContextCurrent, [:pointer], :ALCboolean
    attach_function :alcProcessContext, [:pointer], :void
    attach_function :alcSuspendContext, [:pointer], :void
    attach_function :alcDestroyContext, [:pointer], :void
    attach_function :alcGetCurrentContext, [], :pointer
    attach_function :alcGetContextsDevice, [:pointer], :pointer
    attach_function :alcGetError, [], :ALCenum
    attach_function :alcIsExtensionPresent, [:pointer, :pointer], :ALCboolean
    attach_function :alcGetProcAddress, [:pointer, :pointer], :pointer
    attach_function :alcGetEnumValue, [:pointer, :pointer], :ALCenum
    attach_function :alcGetString, [:pointer, :ALCenum], :pointer
    attach_function :alcGetIntegerv, [:pointer, :ALCenum, :ALCsizei, :ALCint], :void
    attach_function :alcCaptureOpenDevice, [:pointer, :ALCuint, :ALCenum, :ALCsizei], :pointer
    attach_function :alcCloseDevice, [:pointer], :ALCboolean
    attach_function :alcCaptureCloseDevice, [:pointer], :ALCboolean
    attach_function :alcCaptureStart, [:pointer], :void
    attach_function :alcCaptureStop, [:pointer], :void
    attach_function :alcCaptureSamples, [:pointer, :pointer, :ALCsizei], :void
end
