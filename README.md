# omnivisualiser

* [Home](https://github.com/mrpraline/omnivisualiser)

Tools to help visualise OmniFocus in different formats.

## OPMLExport

OPMLExport provides a simple method to export all active folders, projects and tasks as OPML. It requires rb-appscript and builder (installable with rubygems).

### Notes

I've tested this on ruby 1.8.7 (the default version provided in Mountain Lion).

### Installation

_I don't think you need to install the XCode developer tools but I could be wrong..._

1. sudo gem install rb-appscript
2. sudo gem install builder

### Usage

> opmlexport > filename.opml

### TODO

* tests
* add command line options to specify:
    * filtering (e.g. include done, dropped, etc.) 
    * OPML header info

## License

This project makes use of work derived from the [Seattle Ruby Brigade](https://github.com/seattlerb/) available [here](https://github.com/seattlerb/omnifocus). As a result, some parts of this codebase are (c) Ryan Davis, seattle.rb.
