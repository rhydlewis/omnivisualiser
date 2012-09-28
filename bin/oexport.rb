#! /usr/bin/env ruby -I ../lib/

# == Synopsis 
#
# == Usage 
#
# == Options
#   -h, --help          Displays help message
#
# == Author
#   Rhyd Lewis
#
# == Copyright
#   Copyright (c) 2012 Rhyd Lewis

require 'json'
require 'ostruct'
require 'optparse'

require '../lib/omnivisualiser/omnifocus'
require '../lib/omnivisualiser/item'
require '../lib/omnivisualiser/folder'
require '../lib/omnivisualiser/project'
require '../lib/omnivisualiser/task'
require '../lib/omnivisualiser/context'
require '../lib/opmlexport'

class OExport
  VERSION = '0.1'
  
  attr_reader :options

  def initialize(args, stdin)
    @arguments = args
    @stdin = stdin 
    @options = OpenStruct.new
    @banner = "Usage: oexport [options] format"
    @format = "  where 'format' is either:\n" +
      "    * 'opml' to output OmniFocus data as OPML data\n" +
      "    * 'json' to output OmniFocus data as a JSON string\n"
      "    * 'hash' to output OmniFocus data as {data}.inspect\n"
  end

  def run  
    if (parsed_options? && !arguments_valid?)
      usage_and_exit
    end

    if (parsed_options? && arguments_valid?)
      process_arguments
    end
  end

  protected

    def output_options
      @options.marshal_dump.each do |name, val|        
        puts "  #{name}: #{val}"
      end
    end

    def parsed_options?
      
      # Specify options
      opts = OptionParser.new
      opts.banner = @banner
      opts.on('-d', '--dropped', 'Include dropped projects in output') { @options.dropped = true }
      opts.on('-c', '--completed', 'Include completed projects and tasks in output') { @options.completed = true }
      opts.on('-h', '--help', 'Display this screen' ) do
        puts opts
        puts 
        puts @format
        exit(0)
      end
      
      opts.parse!(@arguments) rescue return false

      true
    end
    
    # True if required arguments were provided
    def arguments_valid?
      # TO DO - implement your real logic here      
      @arguments.length == 1 ? true : false
    end

    # Setup the arguments
    def process_arguments
      arg = @arguments[0]
      if (arg == "opml")
        puts as_opml
      elsif (arg == "json")
        puts as_json
      elsif (arg == "hash")
        puts as_hash.inspect
      else
        usage_and_exit
      end
    end

    def as_opml
      opml = ""
      OmniVisualiser::OPMLExport.new.export(JSON.parse(as_json), opml, @options.completed, @options.dropped)
      return opml
    end
    
    def as_json
      return as_hash.to_json
    end
  
    def as_hash
      of = OmniVisualiser::OmniFocus.new(Appscript.app('OmniFocus').default_document)
      return of.to_hash
    end
    
    def usage_and_exit
      puts @banner
      puts
      puts @format
      puts
      puts "For help use: oexport -h"
      exit(0)
    end
  
end

app = OExport.new(ARGV, STDIN)
app.run
