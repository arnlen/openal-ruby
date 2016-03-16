require 'ffi'

module EFX
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

    ALC_EXT_EFX                              = 1

    ALC_EFX_MAJOR_VERSION                    = 0x20001
    ALC_EFX_MINOR_VERSION                    = 0x20002
    ALC_MAX_AUXILIARY_SENDS                  = 0x20003

    AL_METERS_PER_UNIT                       = 0x20004
    AL_DIRECT_FILTER                         = 0x20005
    AL_AUXILIARY_SEND_FILTER                 = 0x20006
    AL_AIR_ABSORPTION_FACTOR                 = 0x20007
    AL_ROOM_ROLLOFF_FACTOR                   = 0x20008
    AL_CONE_OUTER_GAINHF                     = 0x20009
    AL_DIRECT_FILTER_GAINHF_AUTO             = 0x2000A
    AL_AUXILIARY_SEND_FILTER_GAIN_AUTO       = 0x2000B
    AL_AUXILIARY_SEND_FILTER_GAINHF_AUTO     = 0x2000C
    AL_REVERB_DENSITY                        = 0x0001
    AL_REVERB_DIFFUSION                      = 0x0002
    AL_REVERB_GAIN                           = 0x0003
    AL_REVERB_GAINHF                         = 0x0004
    AL_REVERB_DECAY_TIME                     = 0x0005
    AL_REVERB_DECAY_HFRATIO                  = 0x0006
    AL_REVERB_REFLECTIONS_GAIN               = 0x0007
    AL_REVERB_REFLECTIONS_DELAY              = 0x0008
    AL_REVERB_LATE_REVERB_GAIN               = 0x0009
    AL_REVERB_LATE_REVERB_DELAY              = 0x000A
    AL_REVERB_AIR_ABSORPTION_GAINHF          = 0x000B
    AL_REVERB_ROOM_ROLLOFF_FACTOR            = 0x000C
    AL_REVERB_DECAY_HFLIMIT                  = 0x000D
    AL_EAXREVERB_DENSITY                     = 0x0001
    AL_EAXREVERB_DIFFUSION                   = 0x0002
    AL_EAXREVERB_GAIN                        = 0x0003
    AL_EAXREVERB_GAINHF                      = 0x0004
    AL_EAXREVERB_GAINLF                      = 0x0005
    AL_EAXREVERB_DECAY_TIME                  = 0x0006
    AL_EAXREVERB_DECAY_HFRATIO               = 0x0007
    AL_EAXREVERB_DECAY_LFRATIO               = 0x0008
    AL_EAXREVERB_REFLECTIONS_GAIN            = 0x0009
    AL_EAXREVERB_REFLECTIONS_DELAY           = 0x000A
    AL_EAXREVERB_REFLECTIONS_PAN             = 0x000B
    AL_EAXREVERB_LATE_REVERB_GAIN            = 0x000C
    AL_EAXREVERB_LATE_REVERB_DELAY           = 0x000D
    AL_EAXREVERB_LATE_REVERB_PAN             = 0x000E
    AL_EAXREVERB_ECHO_TIME                   = 0x000F
    AL_EAXREVERB_ECHO_DEPTH                  = 0x0010
    AL_EAXREVERB_MODULATION_TIME             = 0x0011
    AL_EAXREVERB_MODULATION_DEPTH            = 0x0012
    AL_EAXREVERB_AIR_ABSORPTION_GAINHF       = 0x0013
    AL_EAXREVERB_HFREFERENCE                 = 0x0014
    AL_EAXREVERB_LFREFERENCE                 = 0x0015
    AL_EAXREVERB_ROOM_ROLLOFF_FACTOR         = 0x0016
    AL_EAXREVERB_DECAY_HFLIMIT               = 0x0017
    AL_CHORUS_WAVEFORM                       = 0x0001
    AL_CHORUS_PHASE                          = 0x0002
    AL_CHORUS_RATE                           = 0x0003
    AL_CHORUS_DEPTH                          = 0x0004
    AL_CHORUS_FEEDBACK                       = 0x0005
    AL_CHORUS_DELAY                          = 0x0006
    AL_DISTORTION_EDGE                       = 0x0001
    AL_DISTORTION_GAIN                       = 0x0002
    AL_DISTORTION_LOWPASS_CUTOFF             = 0x0003
    AL_DISTORTION_EQCENTER                   = 0x0004
    AL_DISTORTION_EQBANDWIDTH                = 0x0005
    AL_ECHO_DELAY                            = 0x0001
    AL_ECHO_LRDELAY                          = 0x0002
    AL_ECHO_DAMPING                          = 0x0003
    AL_ECHO_FEEDBACK                         = 0x0004
    AL_ECHO_SPREAD                           = 0x0005
    AL_FLANGER_WAVEFORM                      = 0x0001
    AL_FLANGER_PHASE                         = 0x0002
    AL_FLANGER_RATE                          = 0x0003
    AL_FLANGER_DEPTH                         = 0x0004
    AL_FLANGER_FEEDBACK                      = 0x0005
    AL_FLANGER_DELAY                         = 0x0006
    AL_FREQUENCY_SHIFTER_FREQUENCY           = 0x0001
    AL_FREQUENCY_SHIFTER_LEFT_DIRECTION      = 0x0002
    AL_FREQUENCY_SHIFTER_RIGHT_DIRECTION     = 0x0003
    AL_VOCAL_MORPHER_PHONEMEA                = 0x0001
    AL_VOCAL_MORPHER_PHONEMEA_COARSE_TUNING  = 0x0002
    AL_VOCAL_MORPHER_PHONEMEB                = 0x0003
    AL_VOCAL_MORPHER_PHONEMEB_COARSE_TUNING  = 0x0004
    AL_VOCAL_MORPHER_WAVEFORM                = 0x0005
    AL_VOCAL_MORPHER_RATE                    = 0x0006
    AL_PITCH_SHIFTER_COARSE_TUNE             = 0x0001
    AL_PITCH_SHIFTER_FINE_TUNE               = 0x0002
    AL_RING_MODULATOR_FREQUENCY              = 0x0001
    AL_RING_MODULATOR_HIGHPASS_CUTOFF        = 0x0002
    AL_RING_MODULATOR_WAVEFORM               = 0x0003
    AL_AUTOWAH_ATTACK_TIME                   = 0x0001
    AL_AUTOWAH_RELEASE_TIME                  = 0x0002
    AL_AUTOWAH_RESONANCE                     = 0x0003
    AL_AUTOWAH_PEAK_GAIN                     = 0x0004
    AL_COMPRESSOR_ONOFF                      = 0x0001
    AL_EQUALIZER_LOW_GAIN                    = 0x0001
    AL_EQUALIZER_LOW_CUTOFF                  = 0x0002
    AL_EQUALIZER_MID1_GAIN                   = 0x0003
    AL_EQUALIZER_MID1_CENTER                 = 0x0004
    AL_EQUALIZER_MID1_WIDTH                  = 0x0005
    AL_EQUALIZER_MID2_GAIN                   = 0x0006
    AL_EQUALIZER_MID2_CENTER                 = 0x0007
    AL_EQUALIZER_MID2_WIDTH                  = 0x0008
    AL_EQUALIZER_HIGH_GAIN                   = 0x0009
    AL_EQUALIZER_HIGH_CUTOFF                 = 0x000A
    AL_EFFECT_FIRST_PARAMETER                = 0x0000
    AL_EFFECT_LAST_PARAMETER                 = 0x8000
    AL_EFFECT_TYPE                           = 0x8001
    AL_EFFECT_NULL                           = 0x0000
    AL_EFFECT_REVERB                         = 0x0001
    AL_EFFECT_CHORUS                         = 0x0002
    AL_EFFECT_DISTORTION                     = 0x0003
    AL_EFFECT_ECHO                           = 0x0004
    AL_EFFECT_FLANGER                        = 0x0005
    AL_EFFECT_FREQUENCY_SHIFTER              = 0x0006
    AL_EFFECT_VOCAL_MORPHER                  = 0x0007
    AL_EFFECT_PITCH_SHIFTER                  = 0x0008
    AL_EFFECT_RING_MODULATOR                 = 0x0009
    AL_EFFECT_AUTOWAH                        = 0x000A
    AL_EFFECT_COMPRESSOR                     = 0x000B
    AL_EFFECT_EQUALIZER                      = 0x000C
    AL_EFFECT_EAXREVERB                      = 0x8000
    AL_EFFECTSLOT_EFFECT                     = 0x0001
    AL_EFFECTSLOT_GAIN                       = 0x0002
    AL_EFFECTSLOT_AUXILIARY_SEND_AUTO        = 0x0003
    AL_EFFECTSLOT_NULL                       = 0x0000
    AL_LOWPASS_GAIN                          = 0x0001
    AL_LOWPASS_GAINHF                        = 0x0002
    AL_HIGHPASS_GAIN                         = 0x0001
    AL_HIGHPASS_GAINLF                       = 0x0002
    AL_BANDPASS_GAIN                         = 0x0001
    AL_BANDPASS_GAINLF                       = 0x0002
    AL_BANDPASS_GAINHF                       = 0x0003
    AL_FILTER_FIRST_PARAMETER                = 0x0000
    AL_FILTER_LAST_PARAMETER                 = 0x8000
    AL_FILTER_TYPE                           = 0x8001
    AL_FILTER_NULL                           = 0x0000
    AL_FILTER_LOWPASS                        = 0x0001
    AL_FILTER_HIGHPASS                       = 0x0002
    AL_FILTER_BANDPASS                       = 0x0003

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
    attach_function :alGenEffects, [:ALsizei, :pointer], :ALvoid
    attach_function :alDeleteEffects, [:ALsizei, :pointer], :ALvoid
    attach_function :alIsEffect, [:ALuint], :ALboolean
    attach_function :alEffecti, [:ALuint, :ALenum, :ALint], :ALvoid
    attach_function :alEffectiv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alEffectf, [:ALuint, :ALenum, :ALfloat], :ALvoid
    attach_function :alEffectfv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetEffecti, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetEffectiv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetEffectf, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetEffectfv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGenFilters, [:ALsizei, :pointer], :ALvoid
    attach_function :alDeleteFilters, [:ALsizei, :pointer], :ALvoid
    attach_function :alIsFilter, [:ALuint], :ALboolean
    attach_function :alFilteri, [:ALuint, :ALenum, :ALint], :ALvoid
    attach_function :alFilteriv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alFilterf, [:ALuint, :ALenum, :ALfloat], :ALvoid
    attach_function :alFilterfv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetFilteri, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetFilteriv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetFilterf, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetFilterfv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGenAuxiliaryEffectSlots, [:ALsizei, :pointer], :ALvoid
    attach_function :alDeleteAuxiliaryEffectSlots, [:ALsizei, :pointer], :ALvoid
    attach_function :alIsAuxiliaryEffectSlot, [:ALuint], :ALboolean
    attach_function :alAuxiliaryEffectSloti, [:ALuint, :ALenum, :ALint], :ALvoid
    attach_function :alAuxiliaryEffectSlotiv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alAuxiliaryEffectSlotf, [:ALuint, :ALenum, :ALfloat], :ALvoid
    attach_function :alAuxiliaryEffectSlotfv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetAuxiliaryEffectSloti, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetAuxiliaryEffectSlotiv, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetAuxiliaryEffectSlotf, [:ALuint, :ALenum, :pointer], :ALvoid
    attach_function :alGetAuxiliaryEffectSlotfv, [:ALuint, :ALenum, :pointer], :ALvoid

    # As `alIsFilter` but returns either `true` or `false`.
    def al_filter?( uint )
        send( :alIsFilter, uint ).read_int8.eql? AL_TRUE
    end

    # As `alIsEffect` but returns either `true` or `false`.
    def al_effect?( uint )
        send( :alIsEffect, uint ).read_int8.eql? AL_TRUE
    end

    # As `alIsAuxiliaryEffectSlot` but returns either `true` or `false`.
    def al_auxiliary_effect_slot?( uint )
        send( :alIsAuxiliaryEffectSlot, uint ).read_int8.eql? AL_TRUE
    end
    alias :al_aux_effect_slot? :al_auxiliary_effect_slot?
end
