Before do
  @opml = OmniVisualiser::OPMLExport.new()
end

Given /^that OmniFocus contains this content$/ do |table|
  @json = create_json(table)
end

When /^I export my OmniFocus content to OPML$/ do
  @result = ""
  @opml.export(@json, @result, true, true)
end

Then /^I see an OPML representation of my OmniFocus content$/ do
  verify_opml()
end

def create_json(table)
  json = {}
  @inbox_tasks = []
  @library = []
  
  table.hashes.each do |row|
    # setup OF with tasks from table
    location = row["Parent Location"]
    task = create_task(row)

    if (location == "Inbox")
      @inbox_tasks << task
    else
      paths = location.split(" > ")
      
      if (paths.count == 1)
        @library << create_project(location, row)
      elsif (paths.count == 2)
        project = create_project(paths.last, row)
        folder = create_folder(paths.first, row, [project])
        @library << folder
      else
        # HACK - haven't worked out how to create nested folders
        "".should eq(" ")
      end
      
    end
  end

  json = { "Inbox" => @inbox_tasks, "Library" => @library }

  return [json]
end

def create_task(row)
  return { "name" => row["Task Name"], "type" => "task", "url" => row["Task Link"], 
    "created" => row["Task Created"], "tasks" => []}
end

def create_project(name, row)
  return { "name" => name, "url" => row["Parent Link"], "created" => row["Parent Created"], 
    "type" => "project", "tasks" => [] } 
end

def create_folder(name, row, projects)
  return { "name" => name, "url" => row["Parent Link"], "created" => row["Parent Created"], 
    "type" => "folder", "projects" => projects, "folders" => [] } 
end

def verify_opml()
#   puts "Result: " + @result
  doc = Nokogiri::XML(@result)

  # Verify header
  doc.at_xpath("/opml/head/title").content.should eq("OmniFocus OPML Export")
  
  check_outline("Inbox", doc, @inbox_tasks)
  check_outline("Library", doc, @library)
end

def check_outline(name, doc, collection)
  nodes = doc.xpath("//outline[@text='" + name + "']")
  nodes[0]["text"].should eq(name)
  child_nodes = nodes[0].element_children
  child_nodes.count.should eq(collection.count)
  child_nodes.each_with_index { |child, i| 
    item = collection[i]
    check_attributes(child.attributes, item["name"], item["url"], item["created"])
  }  
end

def check_attributes(attr, name, url, created)
  attr["text"].content.should eq(name)
  attr["type"].content.should eq("link")
  attr["url"].content.should eq(url)
  attr["created"].content.should eq(created)
end