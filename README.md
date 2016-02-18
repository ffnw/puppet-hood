# puppet-hood

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with hood](#setup)
    * [Beginning with hood](#beginning-with-hood)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Creates and configures hoods.

## Setup

### Beginning with hood

```puppet
hood::create { 'ol-nord':
  subnet  => '10.18.8.0/21',
  subnet6 => '2a03:2260:1001:0800::/53',
}
```

## Usage

```puppet
hood::create { 'ol-nord':
  subnet  => '10.18.8.0/21',
  subnet6 => '2a03:2260:1001:0800::/53',
  fastd   => 4,
}
```

## Reference

* define hood::create
  * $subnet
  * $subnet6
  * $fastd (optional, default 1)

## Limitations

### OS compatibility
* Debian 8

## Development

### How to contribute
Fork the project, work on it and submit pull requests, please.

