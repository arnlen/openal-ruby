OpenAL SOFT for Ruby
====================

This is a wrapper to OpenAL SOFT written via Ruby-FFI.  It includes AL, ALC, EFX, and EXT support.

## Dependencies

Your system must have OpenAL SOFT support or an equivalent `libopenal`:

| Linux            | Mac OSX             | Windows           |
|------------------|---------------------|-------------------|
| libopenal.so     | libAL.dylib         | soft_oal.dll      |

### On Mac OSX

Install OpenAL SOFT with [Homebrew](http://brew.sh/):

```
brew install openal-soft
```

Add this line to your shell config file (ie: ~/.zshrc for ZSH):

```
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/opt/openal-soft/lib
```

Close and reopen your shell.

## Installation

`gem install openal-soft`

## Usage

To use this gem, simply do the following:

```rb
require 'al'        # provides base OpenAL
require 'alc'       # provides ALC
require 'efx'       # provides OpenAL SOFT's EFX library
require 'ext'       # provides OpenAL SOFT's EXT library
```

For more information, see [Strangesoft.net](http://kcat.strangesoft.net/openal.html).