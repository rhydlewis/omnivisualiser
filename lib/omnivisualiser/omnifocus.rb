# == Synopsis 
#   Ruby wrapper around the OmniFocus AppleScript class.
#
# == Author
#   Rhyd Lewis (but see below)
#
# == Licence
#
# This project makes use of work derived from the Seattle Ruby Brigade (https://github.com/seattlerb/)
# available at https://github.com/seattlerb/omnifocus. Some parts of this codebase are 
# (c) Ryan Davis, seattle.rb.

require 'rubygems'
require 'appscript'
include Appscript

module OmniVisualiser
  class OmniFocus
  
  	@hash
  	
    def initialize(omnifocus_app)
      @omnifocus = omnifocus_app
    end
    
    def omnifocus()
      return @omnifocus
    end
    
#     def all_subtasks(task)
#       [task] + task.tasks.get.flatten.map{ |t| all_subtasks(t) }
#     end
#     
#     def all_tasks()
#       omnifocus.flattened_projects.tasks.get.flatten.map { |t| Task.new(omnifocus, t) }
#     end
#   
#     def incomplete_tasks()
#       tasks = all_tasks()
#       incomplete_tasks = []      
#       for i in 0 ... all_tasks.count
#         t = tasks[i]
#         if (!t.completed() && t.project().status() == :active) then
#           incomplete_tasks = incomplete_tasks + [t]
#         end
#       end
#       
#       return incomplete_tasks
#     end
# 
    def inbox_tasks()
      omnifocus.inbox_tasks.get.flatten.map { |t| Task.new(omnifocus, t) }
    end
#   
#     def all_folders()
#       self.omnifocus.flattened_folders.get.map { |f| Folder.new(omnifocus, f) }
#     end
# 
#     def all_projects()
#       self.omnifocus.flattened_projects.get.map { |p| Project.new(omnifocus, p) }
#     end
#   
#     def all_contexts()
#       self.omnifocus.flattened_contexts.get.map { |c| Context.new(omnifocus, c) }
#     end
    
    def folders()
      self.omnifocus.folders.get.map { |f| Folder.new(omnifocus, f) }
    end

    def projects()
      self.omnifocus.projects.get.map { |p| Project.new(omnifocus, p) }
    end
    
    def to_hash()
    	@hash = []
    	tasks = []
    	library = []

    	# Add inbox tasks
    	inbox_tasks.each { |item| tasks << item.to_hash() }
    	
    	# iterate through each top-level folder and parse
    	folders.each { |item| library << item.to_hash() }

      # iterate through each top-level project outside of a folder and parse
    	projects.each { |item| library << item.to_hash() }

    	@hash << { "Inbox" => tasks }
    	@hash << { "Library" => library }

			return @hash
    end    
  end
end
