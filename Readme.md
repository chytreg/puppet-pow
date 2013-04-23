# Pow! Puppet Module for Boxen

Installs and sets up Pow!.

## Usage

```puppet
include pow
```

site.pp Includes nvm and nodejs by default, add the following if you've removed it.
```puppet
# core modules, needed for most things
include nvm

# node versions
include nodejs::0-6
```

# Required Puppet Modules

* `boxen`
* `homebrew`
* `nodejs`
* `nvm`

## Developing

Write code.

