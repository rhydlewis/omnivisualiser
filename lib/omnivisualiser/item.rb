# == Synopsis 
#   Superclass for OmniFocus AppleScript elements.
#
# == Author
#   Rhyd Lewis (derived from code written by Ryan Davis of seattle.rb)

module OmniVisualiser
  class Item
    attr_accessor :omnifocus, :item, :name

    def initialize(of, item)
      @omnifocus = of
      @item = item
      
      if (item == :missing_value) then
        @name = ""
      else
        @name = (item.name.get == :missing_value ? "" : item.name.get)
      end
    end

    def active()
      item.completed.eq(false)
    end
        
    def id()
      item.id_.get
    end
    
    def creation_date()
      item.creation_date.get
    end
  end
end