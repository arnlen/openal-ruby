OpenAL SOFT for Ruby
====================

This is a wrapper to OpenAL SOFT written via Ruby-FFI.  It includes AL, ALC, EFX, and EXT support.

Your system must have OpenAL SOFT support or an equivalent `libopenal`:

| Linux            | Mac OSX             | Windows           |
|------------------|---------------------|-------------------|
| libopenal.so     | libAL.dylib         | soft_oal.dll      |

To use this gem, simply do the following:

```rb
require 'al'        # provides base OpenAL
require 'alc'       # provides ALC
require 'efx'       # provides OpenAL SOFT's EFX library
require 'ext'       # provides OpenAL SOFT's EXT library
```

For more information, see [Strangesoft.net](http://kcat.strangesoft.net/openal.html).
