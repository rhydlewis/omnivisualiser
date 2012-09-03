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
    
    def status()
      item.status.get
    end
    
    def folder()
      item.folder.get == :missing_value ? nil : item.folder.get
    end
    
    def to_s()
      name + " (" + status.to_s + ")"
    end

    def url()
      "omnifocus:///task/" + id
    end
  end
end