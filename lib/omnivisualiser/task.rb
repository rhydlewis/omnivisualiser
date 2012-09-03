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
      url + ", name " + name + ", flagged " + flagged.to_s + ", due " + due_date.to_s + ", completed " + completed.to_s + ", context " + context.to_s
    end
  end
end