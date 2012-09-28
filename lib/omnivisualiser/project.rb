# == Synopsis 
#   Ruby wrapper around an AppleScript folder element.
#
# == Author
#   Rhyd Lewis (derived from code written by Ryan Davis of seattle.rb)

module OmniVisualiser
  class Project < Item
    def tasks()
      item.tasks.get.map { |t| Task.new omnifocus, t }
    end
    
    def folder()
      item.folder.get == :missing_value ? nil : item.folder.get
    end
    
    def status()
      item.status.get
    end
    
    def to_s()
      name + " (" + status.to_s + ")"
    end

    def url()
      "omnifocus:///task/" + id
    end
    
		def to_hash(include_completed, include_dropped)
      is_dropped = status == "dropped"
      is_completed = status == "done"
    
      if (is_dropped && !include_dropped || is_completed && !include_completed)
        return nil
      end
			
    	sub_tasks = []
			tasks.each { |item|
    		st = item.to_hash(include_completed)
    		sub_tasks << st unless st.nil?
    	}
    	return { :name => name, :url => url, :created => creation_date, :status => status, 
    		:folder => folder, :type => "project", :tasks => sub_tasks}
    end       
  end
end