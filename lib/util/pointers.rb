require 'ffi'

NilClass.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        FFI::MemoryPointer::NULL
    end
}

TrueClass.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        1.pointer
    end
}

FalseClass.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        0.pointer
    end
}

String.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        FFI::MemoryPointer.from_string( self )
    end
}

Fixnum.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        [self].pointer( :int )
    end
}

Bignum.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        [self].pointer( :long )
    end
}

Float.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        [self].pointer( :float )
    end
}

Array.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer( type = nil )
        # perform introspection and allocate the pointer
        ptr = nil
        case type ||= self[0]
            when Bignum, :long, :int64, :int64_t
                p = 'q'
                ptr = FFI::MemoryPointer.new( :long, self.length )
            when :ulong, :uint64, :uint64_t
                p = 'Q'
                ptr = FFI::MemoryPointer.new( :long, self.length )
            when Fixnum, :int, :int32, :int32_t
                p = 'l'
                ptr = FFI::MemoryPointer.new( :int, self.length )
            when :uint, :uint32, :uint32_t
                p = 'L'
                ptr = FFI::MemoryPointer.new( :int, self.length )
            when :short, :int16, :int16_t
                p = 's'
                ptr = FFI::MemoryPointer.new( :short, self.length )
            when :ushort, :uint16, :uint16_t
                p = 'S'
                ptr = FFI::MemoryPointer.new( :short, self.length )
            when :byte, :char
                p = 'c'
                ptr = FFI::MemoryPointer.new( :char, self.length )
            when :ubyte, :uchar
                p = 'C'
                ptr = FFI::MemoryPointer.new( :char, self.length )
            when Float, :float
                p = 'f'
                ptr = FFI::MemoryPointer.new( :float, self.length )
            when :double
                p = 'd'
                ptr = FFI::MemoryPointer.new( :double, self.length )
            when String
                return join.pointer
            else
                raise Exception, "unrecognized or invalid data type: #{type.class.name}"
        end

        # fill with byte data
        ptr.write_bytes( self.pack( p ) )
        ptr
    end
}

FFI::MemoryPointer.class_eval %q{

    # Read a FFI::MemoryPointer into an array.  If only a single value exists, that value alone is returned.
    def read( type )
        n = size() / type_size()
        out = case type ||= self[0]
            when Bignum, :long, :int64, :int64_t then read_array_of_long( n )
            when :ulong, :uint64, :uint64_t then read_array_of_long( n )
            when Fixnum, :int, :int32, :int32_t then read_array_of_int( n )
            when :uint, :uint32, :uint32_t then read_array_of_int( n )
            when :short, :int16, :int16_t then read_array_of_short( n )
            when :ushort, :uint16, :uint16_t then read_array_of_short( n )
            when :byte, :char then read_array_of_char( n )
            when :ubyte, :uchar then read_array_of_char( n )
            when Float, :float then read_array_of_float( n )
            when :double then read_array_of_double( n )
            else
                raise Exception, "unrecognized or invalid data type: #{type.class.name}"
        end
        out.length == 1 ? out[0] : out
    end
}
