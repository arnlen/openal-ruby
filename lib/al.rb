require 'ffi'

module AL
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
                'C:/Windows/System32/openal32.dll'
            end
        when /linux|unix|bsd/ix
            'libopenal.so'
    end

    AL_VERSION_1_0                  = 1
    AL_VERSION_1_1                  = 1

    AL_NONE                         = 0x0000
    AL_FALSE                        = 0x0000
    AL_TRUE                         = 0x0001
    AL_SOURCE_RELATIVE              = 0x0202
    AL_CONE_INNER_ANGLE             = 0x1001
    AL_CONE_OUTER_ANGLE             = 0x1002
    AL_PITCH                        = 0x1003
    AL_POSITION                     = 0x1004
    AL_DIRECTION                    = 0x1005
    AL_VELOCITY                     = 0x1006
    AL_LOOPING                      = 0x1007
    AL_BUFFER                       = 0x1009
    AL_GAIN                         = 0x100A
    AL_MIN_GAIN                     = 0x100D
    AL_MAX_GAIN                     = 0x100D
    AL_ORIENTATION                  = 0x100F
    AL_SOURCE_STATE                 = 0x1010
    AL_INITIAL                      = 0x1011
    AL_PLAYING                      = 0x1012
    AL_PAUSED                       = 0x1013
    AL_STOPPED                      = 0x1014
    AL_BUFFERS_QUEUED               = 0x1015
    AL_BUFFERS_PROCESSED            = 0x1016
    AL_SEC_OFFSET                   = 0x1024
    AL_SAMPLE_OFFSET                = 0x1025
    AL_BYTE_OFFSET                  = 0x1026
    AL_SOURCE_TYPE                  = 0x1027
    AL_STATIC                       = 0x1028
    AL_STREAMING                    = 0x1029
    AL_UNDETERMINED                 = 0x1030
    AL_FORMAT_MONO8                 = 0x1100
    AL_FORMAT_MONO16                = 0x1101
    AL_FORMAT_STEREO8               = 0x1102
    AL_FORMAT_STEREO16              = 0x1103
    AL_REFERENCE_DISTANCE           = 0x1020
    AL_ROLLOFF_FACTOR               = 0x1021
    AL_CONE_OUTER_GAIN              = 0x1022
    AL_MAX_DISTANCE                 = 0x1023
    AL_FREQUENCY                    = 0x2001
    AL_BITS                         = 0x2002
    AL_CHANNELS                     = 0x2003
    AL_SIZE                         = 0x2004
    AL_UNUSED                       = 0x2010
    AL_PENDING                      = 0x2011
    AL_PROCESSED                    = 0x2012
    AL_NO_ERROR                     = 0x0000
    AL_INVALID_NAME                 = 0xA001
    AL_INVALID_ENUM                 = 0xA002
    AL_INVALID_VALUE                = 0xA003
    AL_INVALID_OPERATION            = 0xA004
    AL_OUT_OF_MEMORY                = 0xA005
    AL_VENDOR                       = 0xB001
    AL_VERSION                      = 0xB002
    AL_RENDERER                     = 0xB003
    AL_EXTENSIONS                   = 0xB004
    AL_DOPPLER_FACTOR               = 0xC000
    AL_DOPPLER_VELOCITY             = 0xC001
    AL_SPEED_OF_SOUND               = 0xC003
    AL_DISTANCE_MODEL               = 0xD000
    AL_INVERSE_DISTANCE             = 0xD001
    AL_INVERSE_DISTANCE_CLAMPED     = 0xD002
    AL_LINEAR_DISTANCE              = 0xD003
    AL_LINEAR_DISTANCE_CLAMPED      = 0xD004
    AL_EXPONENT_DISTANCE            = 0xD005
    AL_EXPONENT_DISTANCE_CLAMPED    = 0xD006

    # define types
    typedef :char,      :ALboolean
    typedef :char,      :ALchar
    typedef :char,      :ALbyte
    typedef :uchar,     :ALubyte
    typedef :short,     :ALshort
    typedef :uint16,    :ALushort
    typedef :int,       :ALint
    typedef :uint,      :ALuint
    typedef :int,       :ALsizei
    typedef :int,       :ALenum
    typedef :float,     :ALfloat
    typedef :double,    :ALdouble
    typedef :void,      :ALvoid

    # declare entry-points
    attach_function :alEnable, [:ALenum], :void
    attach_function :alDisable, [:ALenum], :void
    attach_function :alIsEnabled, [:ALenum], :ALboolean
    attach_function :alGetString, [:ALenum], :string
    attach_function :alGetBooleanv, [:ALenum, :pointer], :void
    attach_function :alGetIntegerv, [:ALenum, :pointer], :void
    attach_function :alGetFloatv, [:ALenum, :pointer], :void
    attach_function :alGetDoublev, [:ALenum, :pointer], :void
    attach_function :alGetBoolean, [:ALenum], :ALboolean
    attach_function :alGetInteger, [:ALenum], :ALint
    attach_function :alGetFloat, [:ALenum], :ALfloat
    attach_function :alGetDouble, [:ALenum], :ALdouble
    attach_function :alGetError, [], :ALenum
    attach_function :alIsExtensionPresent, [:pointer], :ALboolean
    attach_function :alGetProcAddress, [:pointer], :pointer
    attach_function :alGetEnumValue, [:pointer], :ALenum
    attach_function :alListenerf, [:ALenum, :ALfloat], :void
    attach_function :alListener3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alListenerfv, [:ALenum, :pointer], :void
    attach_function :alListeneri, [:ALenum, :ALint], :void
    attach_function :alListener3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alListeneriv, [:ALenum, :pointer], :void
    attach_function :alGetListenerf, [:ALenum, :ALfloat], :void
    attach_function :alGetListener3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alGetListenerfv, [:ALenum, :pointer], :void
    attach_function :alGetListeneri, [:ALenum, :ALint], :void
    attach_function :alGetListener3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alGetListeneriv, [:ALenum, :pointer], :void
    attach_function :alGenSources, [:ALsizei, :pointer], :void
    attach_function :alDeleteSources, [:ALsizei, :pointer], :void
    attach_function :alIsSource, [:ALuint], :ALboolean
    attach_function :alSourcef, [:ALenum, :ALfloat], :void
    attach_function :alSource3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alSourcefv, [:ALenum, :pointer], :void
    attach_function :alSourcei, [:ALenum, :ALint], :void
    attach_function :alSource3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alSourceiv, [:ALenum, :pointer], :void
    attach_function :alGetSourcef, [:ALenum, :ALfloat], :void
    attach_function :alGetSource3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alGetSourcefv, [:ALenum, :pointer], :void
    attach_function :alGetSourcei, [:ALenum, :ALint], :void
    attach_function :alGetSource3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alGetSourceiv, [:ALenum, :pointer], :void
    attach_function :alSourcePlayv, [:ALsizei, :pointer], :void
    attach_function :alSourceStopv, [:ALsizei, :pointer], :void
    attach_function :alSourceRewindv, [:ALsizei, :pointer], :void
    attach_function :alSourcePausev, [:ALsizei, :pointer], :void
    attach_function :alSourcePlay, [:pointer], :void
    attach_function :alSourceStop, [:pointer], :void
    attach_function :alSourceRewind, [:pointer], :void
    attach_function :alSourcePause, [:pointer], :void
    attach_function :alSourceQueueBuffers, [:ALuint, :ALsizei, :pointer], :void
    attach_function :alSourceUnqueueBuffers, [:ALuint, :ALsizei, :pointer], :void
    attach_function :alGenBuffers, [:ALsizei, :pointer], :void
    attach_function :alDeleteBuffers, [:ALsizei, :pointer], :void
    attach_function :alIsBuffer, [:ALuint], :ALboolean
    attach_function :alBufferf, [:ALenum, :ALfloat], :void
    attach_function :alBuffer3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alBufferfv, [:ALenum, :pointer], :void
    attach_function :alBufferi, [:ALenum, :ALint], :void
    attach_function :alBuffer3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alBufferiv, [:ALenum, :pointer], :void
    attach_function :alGetBufferf, [:ALenum, :ALfloat], :void
    attach_function :alGetBuffer3f, [:ALenum, :ALfloat, :ALfloat, :ALfloat], :void
    attach_function :alGetBufferfv, [:ALenum, :pointer], :void
    attach_function :alGetBufferi, [:ALenum, :ALint], :void
    attach_function :alGetBuffer3i, [:ALenum, :ALint, :ALint, :ALint], :void
    attach_function :alDopplerFactor, [:ALfloat], :void
    attach_function :alDopplerVelocity, [:ALfloat], :void
    attach_function :alSpeedOfSound, [:ALfloat], :void
    attach_function :alDistanceModel, [:ALenum], :void

    # As `alIsExtensionPresent` but returns either `true` or `false`.
    def al_extension?( extstr )
        send( :alIsExtensionPresent, extstr ).read_int8.eql? AL_TRUE
    end

    # As `alIsEnabled` but returns either `true` or `false`.
    def al_enabled?( enum )
        send( :alIsEnabled, enum ).read_int8.eql? AL_TRUE
    end

    # As `alGetBoolean` but returns either `true` or `false`.
    def al_bool( enum )
        send( :alGetBoolean, enum ).read_int8eql? AL_TRUE
    end
    alias :al_boolean :al_bool

    # As `alGetInteger` but returns an instance of Fixnum.
    def al_int( enum )
        send( :alGetInteger, enum ).read_int32
    end
    alias :al_integer :al_int

    # As `alGetInteger` but returns a single-precision instance of Float (<= 32 bits).
    def al_float( enum )
        send( :alGetFloat, enum ).read_float
    end

    # As `alGetInteger` but returns a double-precision instance of Float (<= 64 bits).
    def al_double( enum )
        send( :alGetDouble, enum ).read_double
    end

    # As `alIsSource` but returns either `true` or `false`.
    def al_source?( uint )
        send( :alIsSource, uint ).read_int8.eql? AL_TRUE
    end

    # As `alIsBuffer` but returns either `true` or `false`.
    def al_buffer?( uint )
        send( :alIsBuffer, uint ).read_int8.eql? AL_TRUE
    end
end
