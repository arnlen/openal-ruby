require 'efx'
require 'util/pointers'

# OpenAL EFX-based equalizer.
class EFX::Equalizer
    include EFX

    # Low gain
    attr_reader :low_gain
    # Low cutoff
    attr_reader :low_cutoff
    # High gain
    attr_reader :high_gain
    # High cutoff
    attr_reader :high_cutoff
    # Mid 1 gain
    attr_reader :mid1_gain
    # Mid 1 center
    attr_reader :mid1_center
    # Mid 1 width
    attr_reader :mid1_width
    # Mid 2 gain
    attr_reader :mid2_gain
    # Mid 2 center
    attr_reader :mid2_center
    # Mid 2 width
    attr_reader :mid2_width
    # Filter slot
    attr :filter

    # Initialize.
    def initialize( low_gain: 1.0, low_cutoff: 1.0, mid1_gain: 1.0, mid1_center: 1.0, mid1_width: 1.0, mid2_gain: 1.0,
                    mid2_center: 1.0, mid2_width: 1.0, high_gain: 1.0, high_cutoff: 1.0 )
        @filter = nil
        self.low_gain = low_gain
        self.low_cutoff = low_cutoff
        self.mid1_gain = mid1_gain
        self.mid1_center = mid1_center
        self.mid1_width = mid1_width
        self.mid2_gain = mid2_gain
        self.mid2_center = mid2_center
        self.mid2_width = mid2_width
        self.high_gain = high_gain
        self.high_cutoff = high_cutoff
    end

    # Set the low gain.
    def low_gain=( g )
        @low_gain = g
        alFilterf( filter, AL_EQUALIZER_LOW_GAIN, @low_gain )
    end

    # Set the low cutoff.
    def low_cutoff=( c )
        @low_cutoff = c
        alFilterf( filter, AL_EQUALIZER_LOW_CUTOFF, @low_cutoff )
    end

    # Set the mid1 gain.
    def mid1_gain=( g )
        @mid1_gain = g
        alFilterf( filter, AL_EQUALIZER_MID1_GAIN, @mid1_gain )
    end

    # Set the mid1 width.
    def mid1_width=( w )
        @mid1_width = w
        alFilterf( filter, AL_EQUALIZER_MID1_WIDTH, @mid1_width )
    end

    # Set the mid1 center.
    def mid1_center=( c )
        @mid1_center = c
        alFilterf( filter, AL_EQUALIZER_MID1_CENTER, @mid1_center )
    end

    # Set the mid2 gain.
    def mid2_gain=( g )
        @mid2_gain = g
        alFilterf( filter, AL_EQUALIZER_MID2_GAIN, @mid2_gain )
    end

    # Set the mid2 width.
    def mid2_width=( w )
        @mid2_width = w
        alFilterf( filter, AL_EQUALIZER_MID2_WIDTH, @mid2_width )
    end

    # Set the mid2 center.
    def mid2_center=( c )
        @mid2_center = c
        alFilterf( filter, AL_EQUALIZER_MID2_CENTER, @mid2_center )
    end

    # Set the high gain.
    def high_gain=( g )
        @high_gain = g
        alFilterf( filter, AL_EQUALIZER_HIGH_GAIN, @high_gain )
    end

    # Set the high cutoff.
    def high_cutoff=( c )
        @high_cutoff = c
        alFilterf( filter, AL_EQUALIZER_HIGH_CUTOFF, @high_cutoff )
    end

    # Destroy the equalizer, discarding its filter.
    def destroy!()
        alDeleteFilters( 1, @filter.pointer ) unless @filter.nil?
        @filter = nil
    end

    # Generate the underlying AL Filter.  If one already exists, it will be returned.
    def filter()
        if @filter.nil?
            ptr = 0.pointer
            alGenFilters( 1, ptr )
            @filter = ptr.read_uint
        end
        @filter
    end
end

# Hack for Float to convert to and from decibel values.
Float.class_eval %q{

    # Convert to a decibel value.
    def to_dB()
        Math.log10( self ) * 20.0
    end

    # Convert from a decibel value.
    def self.from_dB( dB )
        10.0 ** ( dB.to_f / 20.0 )
    end
}
