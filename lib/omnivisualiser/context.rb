# == Synopsis 
#   Ruby wrapper around an AppleScript context element.
#
# == Author
#   Rhyd Lewis (derived from code written by Ryan Davis of seattle.rb)

module OmniVisualiser
  class Context < Item
    def tasks()
      item.tasks[active].get.map { |t| Task.new(omnifocus, t) }
    end
    
    def to_s()
      name 
    end
  end
end