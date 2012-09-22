#! /usr/bin/env ruby -I ../lib/

# == Synopsis 
#
# == Usage 
#
# == Options
#   -h, --help          Displays help message
#
#
# == Author
#   Rhyd Lewis

require 'json'
require '../lib/omnivisualiser/omnifocus'
require '../lib/omnivisualiser/item'
require '../lib/omnivisualiser/folder'
require '../lib/omnivisualiser/project'
require '../lib/omnivisualiser/task'
require '../lib/omnivisualiser/context'
require '../lib/opmlexport'

class Visualise
  VERSION = '0.1'
 
  attr_reader :options

  def initialize(args, stdin)
    @arguments = args
    @stdin = stdin
 
  end
  
  def as_opml()
    OmniVisualiser::OPMLExport.new().export(JSON.parse(IO.read("./test.json")))
#     OmniVisualiser::OPMLExport.new().export(as_json)
  end
  
  def as_kanban()
  
  end
  
  def as_json_string()
    return as_hash().to_json
  end

  def as_json()
    return JSON.parse(as_hash().to_json)
  end

  def as_hash()
    of = OmniVisualiser::OmniFocus.new(Appscript.app('OmniFocus').default_document)
    return of.to_hash()
  end
  
end

app = Visualise.new(ARGV, STDIN)
puts app.as_opml
