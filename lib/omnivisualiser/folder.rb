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
    
    def subfolders()
      item.folders.get.map { |f| Folder.new(omnifocus, f) }
    end
    
    def projects()
      item.projects.get.map { |p| Project.new(omnifocus, p) }
    end
  end
end