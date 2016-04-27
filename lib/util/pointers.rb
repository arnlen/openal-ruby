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
        ptr = FFI::MemoryPointer.new( :char, 1 )
        ptr.write_char( 1 )
        ptr
    end
}

FalseClass.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        ptr = FFI::MemoryPointer.new( :char, 1 )
        ptr.write_char( 0 )
        ptr
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
        ptr = FFI::MemoryPointer.new( :int, 1 )
        ptr.write_int( self )
        ptr
    end
}

Bignum.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        ptr = FFI::MemoryPointer.new( :long, 1 )
        ptr.write_int( self )
        ptr
    end
}

Float.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer()
        ptr = FFI::MemoryPointer.new( :float, 1 )
        ptr.write_int( self )
        ptr
    end
}

Array.class_eval %q{

    # Convert to a FFI::MemoryPointer.
    def pointer( type = nil )
        case type ||= self[0]
            when Bignum, :long, :int64, :int64_t
                ptr = FFI::MemoryPointer.new( :long, self.length )
                ptr.write_array_of_long( self )
                ptr
            when :ulong, :uint64, :uint64_t
                ptr = FFI::MemoryPointer.new( :ulong, self.length )
                ptr.write_array_of_ulong( self )
                ptr
            when Fixnum, :int, :int32, :int32_t
                ptr = FFI::MemoryPointer.new( :int, self.length )
                ptr.write_array_of_int( self )
                ptr
            when :uint, :uint32, :uint32_t
                ptr = FFI::MemoryPointer.new( :uint, self.length )
                ptr.write_array_of_uint( self )
                ptr
            when :short, :int16, :int16_t
                ptr = FFI::MemoryPointer.new( :short, self.length )
                ptr.write_array_of_short( self )
                ptr
            when :ushort, :uint16, :uint16_t
                ptr = FFI::MemoryPointer.new( :ushort, self.length )
                ptr.write_array_of_ushort( self )
                ptr
            when :byte, :char, :ubyte, :uchar
                ptr = FFI::MemoryPointer.new( :char, self.length )
                ptr.write_array_of_char( self )
                ptr
            when Float, :float
                ptr = FFI::MemoryPointer.new( :float, self.length )
                ptr.write_array_of_float( self )
                ptr
            when :double
                ptr = FFI::MemoryPointer.new( :double, self.length )
                ptr.write_array_of_double( self )
                ptr
            when String, :string
                join.pointer
            else
                raise Exception, "unrecognized or invalid data type: #{type.class.name}"
        end
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
