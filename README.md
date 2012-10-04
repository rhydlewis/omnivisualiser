# omnivisualiser

* [Home](https://github.com/mrpraline/omnivisualiser)

Tools to help visualise OmniFocus in different formats.

## OExport

OExport allows you to export OmniFocus data as JSON, OPML or a Ruby hash. It requires 
rb-appscript and builder (installable with rubygems).

### Notes

I've tested this on ruby 1.9.3 installed using [RVM](https://rvm.io/).

### Installation

1. sudo gem install rb-appscript
2. sudo gem install builder

### Usage

#### Command line options

 -h, --help     Displays help message   
 -d, --dropped     Include dropped folders and projects in output  
 -c, --completed     Include completed projects and tasks in output  

### Example usage

	$ oexport JSON > omnifocus.json

This will export your active OmniFocus folders, projects and tasks as a JSON string to the file 'omnifocus.json'

	$ oexport -d -c OPML > omnifocus.opml

This will export all OmniFocus data as OPML to the file 'omnifocus.opml'

### TODO

* review and improve tests (swap out Cucumber for RSpec)
* add command line options to specify:
    * OPML header info

## Author

Rhyd Lewis

## Copyright

Copyright (c) 2011 Rhyd Lewis.

## License

This project makes use of work from these people (thanks!):
* the [Seattle Ruby Brigade](https://github.com/seattlerb/) available [here](https://github.com/seattlerb/omnifocus). As a result, some parts of this codebase are (c) Ryan Davis, seattle.rb.
* [OTask](https://github.com/ttscoff/OTask/) by (Brett Terpstra)[http://www.brettterpstra.com]

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.