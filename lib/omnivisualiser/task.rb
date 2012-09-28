# == Synopsis 
#   Ruby wrapper around an AppleScript folder element.
#
# == Author
#   Rhyd Lewis (derived from code written by Ryan Davis of seattle.rb)

module OmniVisualiser
  class Task < Item
    def project()
      Project.new(omnifocus, item.containing_project.get)
    end

    def context()
      Context.new(omnifocus, item.context.get)
    end

    def due_date()
      item.due_date.get == :missing_value ? nil : item.due_date.get
    end

    def start_date()
      item.start_date.get == :missing_value ? nil : item.start_date.get
    end

    def completed()
      item.completed.get == :missing_value ? false : item.completed.get
    end
    
    def flagged()
      item.flagged.get == :missing_value ? false : item.flagged.get
    end
    
    def inbox()
      item.in_inbox.get == :missing_value ? false : item.in_inbox.get
    end
    
    def url()
      "omnifocus:///task/" + id
    end
    
    def tasks()
    	item.tasks.get.map { |t| Task.new(omnifocus, t) }
    end
    
    def to_s()
      url + ", name " + name + ", flagged " + flagged.to_s + ", due " + due_date.to_s + 
      	", completed " + completed.to_s + ", context " + context.to_s
    end
    
    def to_hash(include_completed)
    
    	if (completed && !include_completed)
#     		puts "Ignoring " + to_s 
    		return nil
    	end
    
    	sub_tasks = []
    	tasks.each { |item|
    		st = item.to_hash(include_completed)
    		sub_tasks << st unless st.nil?
    	}
    	return { :name => name, :url => url, :created => creation_date, :completed => completed, 
    		:context => context.to_s, :flagged => flagged, :due_date => due_date, 
    		:start_date => start_date, :type => "task", :tasks => sub_tasks
    	}
    end       
  end
end