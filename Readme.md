# Pow! Puppet Module for Boxen

Installs and sets up Pow!.

## Usage

```puppet
include pow
```

site.pp Includes nvm and nodejs by default, add the following if you've removed it.
```puppet
# node versions
include nodejs::v0_10
```

# Required Puppet Modules

* `boxen`
* `homebrew`
* `nodejs`

## Developing

Write code.

