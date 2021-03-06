#! /usr/bin/env ruby

# == Synopsis 
#
# == Usage 
# Usage: oexport [options] format
#   where 'format' is either:\n" +
#     * 'opml' to output OmniFocus data as OPML data
#     * 'json' to output OmniFocus data as a JSON string
#     * 'hash' to output OmniFocus data as {data}.inspect
#
# == Options
#   -h, --help          Displays help message
#   -d, --dropped       Include dropped projects in output
#   -c, --completed     Include completed projects and tasks in output
#
# == Author
#   Rhyd Lewis
#
# == Copyright
#   Copyright (c) 2012 Rhyd Lewis

require 'json'
require 'ostruct'
require 'optparse'

$: << File.join(File.dirname(__FILE__), "/../lib")

require 'omnivisualiser/omnifocus'
require 'omnivisualiser/item'
require 'omnivisualiser/folder'
require 'omnivisualiser/project'
require 'omnivisualiser/task'
require 'omnivisualiser/context'
require 'opmlexport'

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
      "    * 'json' to output OmniFocus data as a JSON string\n" +
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

    def parsed_options?
      
      # Specify options
      opts = OptionParser.new
      opts.banner = @banner
      opts.on('-d', '--dropped', 'Include dropped folders and projects in output') { @options.dropped = true }
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
      OmniVisualiser::OPMLExport.new.export(JSON.parse(as_json), opml)
      return opml
    end
    
    def as_json
      return as_hash.to_json
    end
  
    def as_hash
      of = OmniVisualiser::OmniFocus.new(Appscript.app('OmniFocus').default_document)
      return of.to_hash(@options.completed, @options.dropped)
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
