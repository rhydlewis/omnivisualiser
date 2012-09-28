# == Synopsis 
#
# == Author
#   Rhyd Lewis

require 'builder'
require 'time'

module OmniVisualiser
  class OPMLExport
    VERSION = '0.1'

# used to build OPML file
#     @builder
#     @completed
#     @dropped
    
    def initialize()

    end
    
    def export(json, target, completed, dropped)
      @include_completed = completed
      @include_dropped = dropped
#       @builder = Builder::XmlMarkup.new(:target => STDOUT, :indent => 2) #:target => target, :indent => 2)
      @builder = Builder::XmlMarkup.new(:target => target, :indent => 2)
      @builder.opml(:version => 1.1) do
      
        # Write XML header
        write_header()
        
        # Iterate through JSON and write out XML body 
        @builder.body do
          
          # Export inbox tasks
          i = json.find { |item| item["Inbox"] }
          @builder.outline("text" => "Inbox", "type" => "text") do
              i["Inbox"].each { |t| parse_task(t) }
          end
                    
          # iterate through each top-level folder and parse
          @builder.outline("text" => "Library", "type" => "text") do
            
            library = json.find { |item| item["Library"] }
            
            if (library != nil)
              library["Library"].each { |item|
                type = item["type"]

                if (type == "folder")
                  parse_folder(item)
                elsif (type == "project")
                  parse_project(item)
                else
                  raise "ERROR: found unexpected type '" + type + "' in '" + item.to_s + "'"
                  exit(-1)
                end
              }
            end
          end
        end
      end
    end
    
    protected
    
    # write standard OPML header
    # @TODO: add cmd line options to set owner name, email etc.
    def write_header()    
      @builder.head do
        @builder.title('OmniFocus OPML Export')
        @builder.dateCreated(Time.now.httpdate)
        @builder.dateModified(Time.now.httpdate)
# TODO         @builder.ownerName("")
# TODO         @builder.ownerEmail('example@example.com')
        end
    end
  
  	# Write folder details as OPML and look into next level down for more folders/projects
    def parse_folder(f)
      is_dropped = f["status"] == "dropped"

      if (is_dropped && !@include_dropped)
        return
      end

      @builder.outline("text" => f["name"], "type" => "link", "url" => f["url"], "created" => f["created"]) do
        f["folders"].each { |sf| parse_folder(sf) }
        f["projects"].each { |p| parse_project(p) }
      end
    end
    
  	# Write project details as OPML and look into next level down for more tasks
    def parse_project(p)
      is_dropped = p["status"] == "dropped"
      is_completed = p["status"] == "done"
    
      if (is_dropped && !@include_dropped || is_completed && !@include_completed)
        return
      end
      
      @builder.outline("text" => p["name"], "type" => "link", "url" => p["url"], "created" => p["created"]) do
        p["tasks"].each { |t| parse_task(t) }
      end
    end
    
  	# Write task details as OPML and look into next level down for more tasks
    def parse_task(t)
      is_completed = t["status"] == "completed"

      if (is_completed && !@include_completed) 
        return
      end
      
      @builder.outline("text" => t["name"], "type" => "link", "url" => t["url"], "created" => t["created"]) do
      	t["tasks"].each { |st| parse_task(st) }
      end
    end
  end
end
