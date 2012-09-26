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
    
		def to_hash()
    	sf_hash = []
    	p_hash = []
    	subfolders.each { |sf| sf_hash << sf.to_hash() }
    	projects.each { |p| p_hash << p.to_hash() }
    	return { :name => name, :url => url, :created => creation_date.to_s, 
    		:type => "folder", :folders => sf_hash, :projects => p_hash }
    end       
    
    def subfolders()
      item.folders.get.map { |f| Folder.new(omnifocus, f) }
    end
    
    def projects()
      item.projects.get.map { |p| Project.new(omnifocus, p) }
    end
  end
end