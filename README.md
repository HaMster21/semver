semver
======

Builds:

Master: [![Master](https://travis-ci.org/mog-wi/semver.svg?branch=master)](https://travis-ci.org/mog-wi/semver)
Latest: [![Latest](https://travis-ci.org/mog-wi/semver.svg)](https://travis-ci.org/mog-wi/semver)

This project is two things:

  1. it's a commandline tool that checks a given string for compliance with the semantic versioning specification.
  2. a dub module that can be used in other project that want to handle version strings compliant with the semantic versioning specification

Both offer the same functionality, one on the command line interface and the other as a D module.

### Command line

When running the semver executable without arguments, a short help will be printed to guide you.

### Library

Everything necessary is contained in source/semver.d, including documentation. 
