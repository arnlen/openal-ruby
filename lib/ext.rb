require 'ffi'

module ALext
    extend FFI::Library

    # Override the default behavior with permissive loading.
    def attach_function( name, func, args, returns = nil, options = nil )
        begin
            super
        rescue Exception, FFI::NotFoundError => err
            warn err.message
        end
    end
    module_function :attach_function

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

    AL_LOKI_IMA_ADPCM_format                = 1
    AL_FORMAT_IMA_ADPCM_MONO16_EXT          = 0x10000
    AL_FORMAT_IMA_ADPCM_STEREO16_EXT        = 0x10001

    AL_LOKI_WAVE_format                     = 1
    AL_FORMAT_WAVE_EXT                      = 0x10002

    AL_EXT_vorbis                           = 1
    AL_FORMAT_VORBIS_EXT                    = 0x10003

    AL_LOKI_quadriphonic                    = 1
    AL_FORMAT_QUAD8_LOKI                    = 0x10004
    AL_FORMAT_QUAD16_LOKI                   = 0x10005

    AL_EXT_float32                          = 1
    AL_FORMAT_MONO_FLOAT32                  = 0x10010
    AL_FORMAT_STEREO_FLOAT32                = 0x10011

    AL_EXT_double                           = 1
    AL_FORMAT_MONO_DOUBLE_EXT               = 0x10012
    AL_FORMAT_STEREO_DOUBLE_EXT             = 0x10013

    AL_EXT_MULAW                            = 1
    AL_FORMAT_MONO_MULAW_EXT                = 0x10014
    AL_FORMAT_STEREO_MULAW_EXT              = 0x10015

    AL_EXT_ALAW                             = 1
    AL_FORMAT_MONO_ALAW_EXT                 = 0x10016
    AL_FORMAT_STEREO_ALAW_EXT               = 0x10017

    ALC_LOKI_audio_channel                  = 1
    ALC_CHAN_MAIN_LOKI                      = 0x500001
    ALC_CHAN_PCM_LOKI                       = 0x500002
    ALC_CHAN_CD_LOKI                        = 0x500003

    AL_EXT_MCFORMATS                        = 1
    AL_FORMAT_QUAD8                         = 0x1204
    AL_FORMAT_QUAD16                        = 0x1205
    AL_FORMAT_QUAD32                        = 0x1206
    AL_FORMAT_REAR8                         = 0x1207
    AL_FORMAT_REAR16                        = 0x1208
    AL_FORMAT_REAR32                        = 0x1209
    AL_FORMAT_51CHN8                        = 0x120A
    AL_FORMAT_51CHN16                       = 0x120B
    AL_FORMAT_51CHN32                       = 0x120C
    AL_FORMAT_61CHN8                        = 0x120D
    AL_FORMAT_61CHN16                       = 0x120E
    AL_FORMAT_61CHN32                       = 0x120F
    AL_FORMAT_71CHN8                        = 0x1210
    AL_FORMAT_71CHN16                       = 0x1211
    AL_FORMAT_71CHN32                       = 0x1212

    AL_EXT_MULAW_MCFORMATS                  = 1
    AL_FORMAT_MONO_MULAW                    = 0x10014
    AL_FORMAT_STEREO_MULAW                  = 0x10015
    AL_FORMAT_QUAD_MULAW                    = 0x10021
    AL_FORMAT_REAR_MULAW                    = 0x10022
    AL_FORMAT_51CHN_MULAW                   = 0x10023
    AL_FORMAT_61CHN_MULAW                   = 0x10024
    AL_FORMAT_71CHN_MULAW                   = 0x10025

    AL_EXT_IMA4                             = 1
    AL_FORMAT_MONO_IMA4                     = 0x1300
    AL_FORMAT_STEREO_IMA4                   = 0x1301

    AL_EXT_STATIC_BUFFER                    = 1

    ALC_EXT_disconnect                      = 1
    ALC_CONNECTED                           = 0x313

    ALC_EXT_thread_local_context            = 1

    AL_EXT_source_distance_model            = 1
    AL_SOURCE_DISTANCE_MODEL                = 0x200

    AL_SOFT_buffer_sub_data                 = 1
    AL_BYTE_RW_OFFSETS_SOFT                 = 0x1031
    AL_SAMPLE_RW_OFFSETS_SOFT               = 0x1032

    AL_SOFT_loop_points                     = 1
    AL_LOOP_POINTS_SOFT                     = 0x2015

    AL_EXT_FOLDBACK                         = 1
    AL_EXT_FOLDBACK_NAME                    = "AL_EXT_FOLDBACK"
    AL_FOLDBACK_EVENT_BLOCK                 = 0x4112
    AL_FOLDBACK_EVENT_START                 = 0x4111
    AL_FOLDBACK_EVENT_STOP                  = 0x4113
    AL_FOLDBACK_MODE_MONO                   = 0x4101
    AL_FOLDBACK_MODE_STEREO                 = 0x4102

    ALC_EXT_DEDICATED                       = 1
    AL_DEDICATED_GAIN                       = 0x0001
    AL_EFFECT_DEDICATED_DIALOGUE            = 0x9001
    AL_EFFECT_DEDICATED_LOW_FREQUENCY_EFFECT= 0x9000

    AL_SOFT_buffer_samples                  = 1
    AL_MONO_SOFT                            = 0x1500
    AL_STEREO_SOFT                          = 0x1501
    AL_REAR_SOFT                            = 0x1502
    AL_QUAD_SOFT                            = 0x1503
    AL_5POINT1_SOFT                         = 0x1504
    AL_6POINT1_SOFT                         = 0x1505
    AL_7POINT1_SOFT                         = 0x1506

    AL_BYTE_SOFT                            = 0x1400
    AL_UNSIGNED_BYTE_SOFT                   = 0x1401
    AL_SHORT_SOFT                           = 0x1402
    AL_UNSIGNED_SHORT_SOFT                  = 0x1403
    AL_INT_SOFT                             = 0x1404
    AL_UNSIGNED_INT_SOFT                    = 0x1405
    AL_FLOAT_SOFT                           = 0x1406
    AL_DOUBLE_SOFT                          = 0x1407
    AL_BYTE3_SOFT                           = 0x1408
    AL_UNSIGNED_BYTE3_SOFT                  = 0x1409

    AL_MONO8_SOFT                           = 0x1100
    AL_MONO16_SOFT                          = 0x1101
    AL_MONO32F_SOFT                         = 0x10010
    AL_STEREO8_SOFT                         = 0x1102
    AL_STEREO16_SOFT                        = 0x1103
    AL_STEREO32F_SOFT                       = 0x10011
    AL_QUAD8_SOFT                           = 0x1204
    AL_QUAD16_SOFT                          = 0x1205
    AL_QUAD32F_SOFT                         = 0x1206
    AL_REAR8_SOFT                           = 0x1207
    AL_REAR16_SOFT                          = 0x1208
    AL_REAR32F_SOFT                         = 0x1209
    AL_5POINT1_8_SOFT                       = 0x120A
    AL_5POINT1_16_SOFT                      = 0x120B
    AL_5POINT1_32F_SOFT                     = 0x120C
    AL_6POINT1_8_SOFT                       = 0x120D
    AL_6POINT1_16_SOFT                      = 0x120E
    AL_6POINT1_32F_SOFT                     = 0x120F
    AL_7POINT1_8_SOFT                       = 0x1210
    AL_7POINT1_16_SOFT                      = 0x1211
    AL_7POINT1_32F_SOFT                     = 0x1212

    AL_INTERNAL_FORMAT_SOFT                 = 0x2008
    AL_BYTE_LENGTH_SOFT                     = 0x2009
    AL_SAMPLE_LENGTH_SOFT                   = 0x200A
    AL_SEC_LENGTH_SOFT                      = 0x200B

    AL_SOFT_direct_channels                 = 1
    AL_DIRECT_CHANNELS_SOFT                 = 0x1033

    ALC_SOFT_loopback                       = 1
    ALC_FORMAT_CHANNELS_SOFT                = 0x1990
    ALC_FORMAT_TYPE_SOFT                    = 0x1991

    ALC_BYTE_SOFT                           = 0x1400
    ALC_UNSIGNED_BYTE_SOFT                  = 0x1401
    ALC_SHORT_SOFT                          = 0x1402
    ALC_UNSIGNED_SHORT_SOFT                 = 0x1403
    ALC_INT_SOFT                            = 0x1404
    ALC_UNSIGNED_INT_SOFT                   = 0x1405
    ALC_FLOAT_SOFT                          = 0x1406

    ALC_MONO_SOFT                           = 0x1500
    ALC_STEREO_SOFT                         = 0x1501
    ALC_QUAD_SOFT                           = 0x1503
    ALC_5POINT1_SOFT                        = 0x1504
    ALC_6POINT1_SOFT                        = 0x1505
    ALC_7POINT1_SOFT                        = 0x1506

    AL_EXT_STEREO_ANGLES                    = 1
    AL_STEREO_ANGLES                        = 0x1030

    AL_EXT_SOURCE_RADIUS                    = 1
    AL_SOURCE_RADIUS                        = 0x1031

    AL_SOFT_source_latency                  = 1
    AL_SAMPLE_OFFSET_LATENCY_SOFT           = 0x1200
    AL_SEC_OFFSET_LATENCY_SOFT              = 0x1201

    ALC_EXT_DEFAULT_FILTER_ORDER            = 1
    ALC_DEFAULT_FILTER_ORDER                = 0x1100

    AL_SOFT_deferred_updates                = 1
    AL_DEFERRED_UPDATES_SOFT                = 0xC002

    AL_SOFT_block_alignment                 = 1
    AL_UNPACK_BLOCK_ALIGNMENT_SOFT          = 0x200C
    AL_PACK_BLOCK_ALIGNMENT_SOFT            = 0x200D

    AL_SOFT_MSADPCM                         = 1
    AL_FORMAT_MONO_MSADPCM_SOFT             = 0x1302
    AL_FORMAT_STEREO_MSADPCM_SOFT           = 0x1303

    AL_SOFT_source_length                   = 1

    ALC_SOFT_pause_device                   = 1

    AL_EXT_BFORMAT                          = 1
    AL_FORMAT_BFORMAT2D_8                   = 0x20021
    AL_FORMAT_BFORMAT2D_16                  = 0x20022
    AL_FORMAT_BFORMAT2D_FLOAT32             = 0x20023
    AL_FORMAT_BFORMAT3D_8                   = 0x20031
    AL_FORMAT_BFORMAT3D_16                  = 0x20032
    AL_FORMAT_BFORMAT3D_FLOAT32             = 0x20033

    AL_EXT_MULAW_BFORMAT                    = 1
    AL_FORMAT_BFORMAT2D_MULAW               = 0x10031
    AL_FORMAT_BFORMAT3D_MULAW               = 0x10032

    ALC_SOFT_HRTF                           = 1
    ALC_HRTF_SOFT                           = 0x1992
    ALC_DONT_CARE_SOFT                      = 0x0002
    ALC_HRTF_STATUS_SOFT                    = 0x1993
    ALC_HRTF_DISABLED_SOFT                  = 0x0000
    ALC_HRTF_ENABLED_SOFT                   = 0x0001
    ALC_HRTF_DENIED_SOFT                    = 0x0002
    ALC_HRTF_REQUIRED_SOFT                  = 0x0003
    ALC_HRTF_HEADPHONES_DETECTED_SOFT       = 0x0004
    ALC_HRTF_UNSUPPORTED_FORMAT_SOFT        = 0x0005
    ALC_NUM_HRTF_SPECIFIERS_SOFT            = 0x1994
    ALC_HRTF_SPECIFIER_SOFT                 = 0x1995
    ALC_HRTF_ID_SOFT                        = 0x1996

    # define types
    typedef :char,      :ALboolean
    typedef :char,      :ALCboolean
    typedef :char,      :ALchar
    typedef :char,      :ALCchar
    typedef :char,      :ALbyte
    typedef :uchar,     :ALubyte
    typedef :short,     :ALshort
    typedef :uint16,    :ALushort
    typedef :int,       :ALint
    typedef :uint,      :ALuint
    typedef :int,       :ALsizei
    typedef :int,       :ALCsizei
    typedef :int,       :ALenum
    typedef :int,       :ALCenum
    typedef :float,     :ALfloat
    typedef :double,    :ALdouble
    typedef :void,      :ALvoid
    typedef :void,      :ALCvoid
    typedef :long,      :int64_t
    typedef :ulong,     :uint64_t
    typedef :long,      :ALint64SOFT
    typedef :ulong,     :ALuint64SOFT

    # declare entry-points
    attach_function :alBufferDataStatic, [:pointer, :ALenum, :pointer, :ALsizei, :ALsizei], :ALvoid
    attach_function :alcSetThreadContext, [:pointer], :ALCboolean
    attach_function :alcGetThreadContext, [], :pointer
    attach_function :alBufferSubDataSOFT, [:ALuint, :ALenum, :pointer, :ALsizei, :ALsizei], :ALvoid
    attach_function :alRequestFoldbackStart, [:ALenum, :ALsizei, :ALsizei, :pointer, :pointer], :void
    attach_function :alRequestFoldbackStop, [], :void
    attach_function :alBufferSamplesSOFT, [:ALuint, :ALuint, :ALenum, :ALsizei, :ALenum, :ALenum, :pointer], :void
    attach_function :alBufferSubSamplesSOFT, [:ALuint, :ALsizei, :ALsizei, :ALenum, :ALenum, :pointer], :void
    attach_function :alGetBufferSamplesSOFT, [:ALuint, :ALsizei, :ALsizei, :ALenum, :ALenum, :pointer], :void
    attach_function :alIsBufferFormatSupportedSOFT, [:ALenum], :ALboolean
    attach_function :alcLoopbackOpenDeviceSOFT, [:pointer], :pointer
    attach_function :alcIsRenderFormatSupportedSOFT, [:pointer, :ALCsizei, :ALCenum, :ALCenum], :ALCboolean
    attach_function :alcRenderSamplesSOFT, [:pointer, :pointer, :ALCsizei], :void
    attach_function :alSourcedSOFT, [:ALuint, :ALenum, :ALdouble], :void
    attach_function :alSource3dSOFT, [:ALuint, :ALenum, :ALdouble, :ALdouble, :ALdouble], :void
    attach_function :alSourcedvSOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alGetSourcedSOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alGetSource3dSOFT, [:ALuint, :ALenum, :pointer, :pointer, :pointer], :void
    attach_function :alGetSourcedvSOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alSourcei64SOFT, [:ALuint, :ALenum, :ALint64SOFT], :void
    attach_function :alSource3i64SOFT, [:ALuint, :ALenum, :ALint64SOFT, :ALint64SOFT, :ALint64SOFT], :void
    attach_function :alSourcei64vSOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alGetSourcei64SOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alGetSource3i64SOFT, [:ALuint, :ALenum, :pointer, :pointer, :pointer], :void
    attach_function :alGetSourcei64vSOFT, [:ALuint, :ALenum, :pointer], :void
    attach_function :alDeferUpdatesSOFT, [], :ALvoid
    attach_function :alProcessUpdatesSOFT, [], :ALvoid
    attach_function :alcDevicePauseSOFT, [:pointer], :void
    attach_function :alcDeviceResumeSOFT, [:pointer], :void
    attach_function :alcGetStringiSOFT, [:pointer, :ALCenum, :ALCsizei], :string
    attach_function :alcResetDeviceSOFT, [:pointer, :pointer], :ALCboolean
end
