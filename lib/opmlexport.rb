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
    @builder
    
    def initialize()

    end
    
    def export(json)
      @builder = Builder::XmlMarkup.new(:target => STDOUT, :indent => 2)
      @builder.opml(:version => 1.1) do
      
        # Write XML header
        write_header()
        
        # Iterate through JSON and write out XML body 
        @builder.body do
          
          # Export inbox tasks
          i = json.find { |item| item["Inbox"] }
          i["Inbox"].each { |t| parse_task(t) }
                    
          # iterate through each top-level folder and parse
          f = json.find { |item| item["Folders"] }
          f["Folders"].each { |sf| parse_folder(sf) }

          # iterate through each top-level project outside of a folder and parse
          p = json.find { |item| item["Projects"] }
          p["Projects"].each { |p| parse_project(p) }
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
      @builder.outline("text" => f["name"], "type" => "link", "url" => f["url"], "created" => f["created"]) do
        f["folders"].each { |sf| parse_folder(sf) }
        f["projects"].each { |p| parse_project(p) }
      end
    end
    
  	# Write project details as OPML and look into next level down for more tasks
    def parse_project(p)
      if (p["status"] == "dropped" || p["status"] == "done")
        return
      end
      @builder.outline("text" => p["name"], "type" => "link", "url" => p["url"], "created" => p["created"]) do
        p["tasks"].each { |t| parse_task(t) }
      end
    end
    
  	# Write task details as OPML and look into next level down for more tasks
    def parse_task(t)
      if (t["completed"] == true) 
        return
      end
      
      @builder.outline("text" => t["name"], "type" => "link", "url" => t["url"], "created" => t["created"]) do
      	t["tasks"].each { |st| parse_task(st) }
      end
    end
  end
end
