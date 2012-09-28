# == Synopsis 
#   Ruby wrapper around an AppleScript folder element.
#
# == Author
#   Rhyd Lewis (derived from code written by Ryan Davis of seattle.rb)

module OmniVisualiser
  class Folder < Item
    def url()
      "omnifocus:///folder/" + id
    end
  
    def to_s()
      url + " " + name 
    end
    
    def status()
      item.hidden.get ? "dropped" : "active"
    end
    
		def to_hash(include_completed, include_dropped)
      if (status == "dropped" && !@include_dropped)
        return nil
      end

    	child_folders = []
    	subfolders.each { |item| 
    		sf = item.to_hash(include_completed, include_dropped) 
    		child_folders << sf unless sf.nil?
    	}

    	child_projects = []
    	projects.each { |item| 
    		p = item.to_hash(include_completed, include_dropped)
    		child_projects << p unless p.nil?
    	}
    	
    	return { :name => name, :url => url, :created => creation_date.to_s, :status => status, 
    		:type => "folder", :folders => child_folders, :projects => child_projects }
    end       
    
    def subfolders()
      item.folders.get.map { |f| Folder.new(omnifocus, f) }
    end
    
    def projects()
      item.projects.get.map { |p| Project.new(omnifocus, p) }
    end
  end
end