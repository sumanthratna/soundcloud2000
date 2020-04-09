# soundcloud9000

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/f210e411578d42e0bff7ebbef3f3ef3c)](https://app.codacy.com/app/sumanthratna/soundcloud9000?utm_source=github.com&utm_medium=referral&utm_content=sumanthratna/soundcloud9000&utm_campaign=Badge_Grade_Dashboard)
[![Gem Version](https://badge.fury.io/rb/soundcloud9000.svg)](https://badge.fury.io/rb/soundcloud9000)
[![Build Status](https://travis-ci.com/sumanthratna/soundcloud9000.svg?branch=master)](https://travis-ci.com/sumanthratna/soundcloud9000)

The next generation SoundCloud client. Without all these stupid CSS files. Runs on macOS and Linux.

![Screen Shot 2019-04-28 at 20 42 40](https://user-images.githubusercontent.com/31281983/56872460-74dd2780-69f7-11e9-9d7e-247757a9a6fd.png)

![Screen Shot 2019-08-02 at 12 31 53](https://user-images.githubusercontent.com/31281983/62384887-8ddb0480-b521-11e9-8e12-dba14b103c38.png)

This hack was originally built at the [Music Hack Day Stockholm 2013](http://stockholm.musichackday.org/2013).

## The Difference Between `soundcloud2000` and `soundcloud9000`

The original software, soundcloud2000, is no longer maintained, and so I've picked it back up so I can add new features.

## Requirements

-   Ruby
    - `ruby 2.5.1` on Ubuntu 18.04
    - `ruby 2.5.1` on macOS 10.13.6
-   Portaudio (19)
-   Mpg123 (1.14)

## Legal

See [this comment](https://github.com/grobie/soundcloud2000/issues/93#issuecomment-233182516).

> \[The] stream needs to be downloaded, which is already against the ToS of SoundCloud. So just by using \[this], you are breaking the law.

## Installation

Assuming you have Ruby/RubyGems installed, you need `portaudio` and `mpg123` installed as libraries to compile the native extensions.

### macOS

```bash
xcode-select --install
brew install portaudio
brew install mpg123
gem install soundcloud9000
```

If you ever encounter a problem with `audite` being `require`d, run:

```bash
gem uninstall audite
gem install --user audite -- --with-ldflags="-lmpg123"
```

See [this comment](https://github.com/grobie/soundcloud2000/issues/96#issuecomment-341915328) for more information.

### Debian / Ubuntu

```bash
apt-get install portaudio19-dev libmpg123-dev libncurses-dev ruby1.9.1-dev
gem install soundcloud9000
```

## Usage

In order to use soundcloud9000, you need to [acquire a client credential for your application](https://stackoverflow.com/a/43962626/7127932). soundcloud9000 expects a valid client id to be set in the `SC_CLIENT_ID` environment variable.

You can either set this up in your `.bashrc` or equivalent or you can specify it on the command line:

```bash
SC_CLIENT_ID=YOUR_CLIENT_ID soundcloud9000
```

## Features

-   stream SoundCloud tracks in your terminal (`enter`)
-   scroll through sound lists (`down` / `up`)
-   play / pause support (`space`)
-   forward / rewind support (`right` / `left`)
-   play tracks of different users (`u`)
-   play favorites from a user (`f`)
-   play sets/playlists from a user (`s`)
-   level meter
-   play songs in random order (`m`)
-   no advertisements
-   live help (`h`)

## Planned

-   sorting tracks
-   custom configuration file
-   live lyrics (don't get your hopes up for this one)

## Authors

-   [Matthias Georgi](https://github.com/georgi) ([@mgeorgi](https://twitter.com/mgeorgi))
-   [Tobias Schmidt](https://github.com/grobie) ([@dagrobie](https://twitter.com/dagrobie))

## Contributors

-   [Travis Thieman](https://github.com/tthieman) ([@tthieman](https://twitter.com/thieman))
-   [Sean Lewis](https://github.com/sophisticasean) ([@FricSean](https://twitter.com/fricsean))

## Current Maintainer

-   [Sumanth Ratna](https://github.com/sumanthratna) ([@sumanthratna](https://twitter.com/sumanthratna))
