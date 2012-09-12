# omnivisualiser

* [Home](https://github.com/mrpraline/omnivisualiser)

Tools to help visualise OmniFocus in different formats.

## OPMLExport

OPMLExport provides a simple method to export all active folders, projects and tasks as OPML. It requires rb-appscript and builder (installable with rubygems).

### Notes

I've tested this on ruby 1.9.3 installed using [RVM](https://rvm.io/).

### Installation

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

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.