require 'efx'
require 'util/pointers'

# Reverberation properties for a sound-scape.
class EFX::Reverb
    include EFX

    # Reverb density
    attr_reader :density
    # Reverb diffusion
    attr_reader :diffusion
    # Reverb gain
    attr_reader :gain
    # High frequency reverb gain
    attr_reader :high_gain
    # Reverb decay time
    attr_reader :decay_time
    # High frequency decay ratio
    attr_reader :decay_ratio
    # Gain of reverberated reflections
    attr_reader :reflection_gain
    # Delay in reverberated reflections
    attr_reader :reflection_delay
    # Late reverb gain
    attr_reader :late_gain
    # Late reverb delay
    attr_reader :late_delay
    # Gain of high frequency sounds related to air absorption
    attr_reader :absorption_gain
    # Rolloff factor for the virtual "room"
    attr_reader :rolloff
    # High frequency reverb decay limit
    attr_reader :decay_limit
    # Effect slot
    attr :effect

    # Initialize.
    def initialize( density: 1.0, diffusion: 1.0, gain: 0.3162, decay_time: 1.49, reflection_gain: 0.05,
                    reflection_delay: 0.007, late_gain: 1.2589, late_delay: 0.011, rolloff: 0.0, high_gain: 0.8913,
                    decay: 0.83, absorption_gain: 0.9943, decay_limit: 1 )
        # generate effect slot
        efxptr = 0.pointer
        alGenEffects( 1, efxptr )
        @effect = efxptr.read_uint

        # bind it
        alEffecti( @effect, AL_EFFECT_TYPE, AL_EFFECT_REVERB )

        # set properties
        self.density = density
        self.diffusion = diffusion
        self.gain = gain
        self.decay_time = decay_time
        self.reflection_gain = reflection_gain
        self.reflection_delay = reflection_delay
        self.late_gain = late_gain
        self.late_delay = late_delay
        self.rolloff = rolloff
        self.high_gain = high_gain
        self.decay = decay
        self.absorption_gain = absorption_gain
        self.decay_limit = decay_limit
    end

    # Set the reverb density.
    def density=( d )
        @density = d
        alEffectf( @effect, AL_REVERB_DENSITY, @density )
    end

    # Set the reverb diffusion.
    def diffusion=( d )
        @diffusion = d
        alEffectf( @effect, AL_REVERB_DIFFUSION, @diffusion )
    end

    # Set the reverb gain.
    def gain=( g )
        @gain = g
        alEffectf( @effect, AL_REVERB_GAIN, @gain )
    end

    # Set the high-frequency reverb gain.
    def high_gain=( g )
        @high_gain = g
        alEffectf( @effect, AL_REVERB_GAINHF, @high_gain )
    end

    # Set the decay time of the reverb.
    def decay_time=( t )
        @decay_time = t
        alEffectf( @effect, AL_REVERB_DECAY_TIME, @decay_time )
    end
    alias :decay= :decay_time=

    # Set the high-frequency decay ratio.
    def decay_ratio=( r )
        @decay_ratio = r
        alEffectf( @effect, AL_REVERB_DECAY_HFRATIO, @decay )
    end
    alias :ratio= :decay_ratio=

    # Set the reverb gain for reflections.
    def reflection_gain=( g )
        @reflection_gain = g
        alEffectf( @effect, AL_REVERB_REFLECTIONS_GAIN, @reflection_gain )
    end

    # Set the reverb delay for reflections.
    def reflection_delay=( d )
        @reflection_delay = d
        alEffectf( @effect, AL_REVERB_REFLECTIONS_DELAY, @reflection_delay )
    end

    # Set the late reverb gain.
    def late_gain=( g )
        @late_gain = g
        alEffectf( @effect, AL_REVERB_LATE_REVERB_GAIN, @late_gain )
    end

    # Set the delay for late reverb.
    def late_delay=( d )
        @late_delay = d
        alEffectf( @effect, AL_REVERB_LATE_REVERB_DELAY, @late_delay )
    end

    # Set the high-frequency reverb absorption gain.
    def absorption_gain=( g )
        @absorption_gain = g
        alEffectf( @effect, AL_REVERB_AIR_ABSORPTION_GAINHF, @absorption_gain )
    end

    # Set the rolloff for the reverb.
    def rolloff=( r )
        @rolloff = r
        alEffectf( @effect, AL_REVERB_ROOM_ROLLOFF_FACTOR, @rolloff )
    end
    alias :rolloff_factor= :rolloff=

    # Set the limit for high-frequency reverberation decay.
    def decay_limit=( l )
        @decay_limit = l
        alEffecti( @effect, AL_REVERB_DECAY_HFLIMIT, @decay_limit )
    end
    alias :limit= :decay_limit=

    # Destroy the effect slot of this object.
    def destroy!()
        alDeleteEffects( 1, @effect.pointer )
    end

    alias :rolloff_factor :rolloff
    alias :decay :decay_time
    alias :limit :decay_limit
    alias :ratio :decay_ratio
end
