require 'matrix'
require_relative '../al'
require_relative '../util/pointers'

# Listener object.
#
# The listener is essentially a static reference, and contains only the most basic properties necessary to
# determine the locality of the listener -- that is, the representation of what "hears" the audio within the audio
# renderer.
#
# All attribute writers are immediate.
module Listener
    include AL
    extend self

    # Location vector; default is (0, 0, 0)
    attr_reader :location
    @location ||= Vector[ 0.0, 0.0, 0.0, 1.0 ]

    # Orientation vector; default is (0, 0, -1)
    attr_reader :orientation
    @orientation ||= Vector[ 0.0, 0.0, -1.0, 0.0 ]

    # Velocity vector; default is motionless (0.0)
    attr_reader :velocity
    @velocity ||= Vector[ 0.0, 0.0, 0.0, 0.0 ]

    # Set the listener's location.
    def location=( vec )
        @location = vec
        alListenerfv( AL_POSITION, vec.to_a[0 .. 2].pointer( :float ) )
    end
    alias :position= :location=

    # Set the listener's velocity.
    def velocity=( vec )
        @velocity = vec
        alListenerfv( AL_VELOCITY, vec.to_a[0 .. 2].pointer( :float ) )
    end

    # Set the listener's orientation.
    def orientation=( vec )
        @orientation = vec
        alListenerfv( AL_ORIENTATION, vec.to_a[0 .. 2].pointer( :float ) )
    end
    alias :direction= :orientation=

    alias :position :location
    alias :direction :orientation
end
