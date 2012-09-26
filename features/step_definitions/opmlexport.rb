Before do
  @opml = OmniVisualiser::OPMLExport.new()
end


Given /^that OmniFocus contains this content$/ do |table|
  @json = create_json(table)
end

When /^I export my OmniFocus content to OPML$/ do
  @result = ""
  @opml.export(@json, @result)
end

Then /^I see an OPML representation of my OmniFocus content$/ do
  verify_opml()
end


def create_json(table)
  json = {}
  @inbox_tasks = []
  @folders = []
  @projects = []
  
  table.hashes.each do |row|
    # setup OF with tasks from table
    location = row["Location"]
    task = { "name" => row["Name"], "url" => row["Link"], "created" => row["Created"], "tasks" => []}

    if (location == "Inbox")
      @inbox_tasks << task
    else
      # TODO  
    
    end
  end

  json = { "Inbox" => @inbox_tasks, "Library" => { "Folders" => @folders, "Projects" => @projects } }

  return [json]
end


def verify_opml()
#   puts "Result: " + @result
  doc = Nokogiri::XML(@result)

  # Verify header
  doc.at_xpath("/opml/head/title").content.should eq("OmniFocus OPML Export")
  
  # Check inbox & library are root level outline elements
#   outlines = doc.xpath("/opml/body/outline")
#   outlines[1]["text"].should eq("Library")
# 
#   nodes = doc.xpath("//outline[@text='Inbox']")
#   nodes[0]["text"].should eq("Inbox")
# 
#   nodes[0].element_children.each_with_index { |item, i| 
#     actual = item["text"]
#     expected = @inbox_tasks[i]["name"]
#     actual.should eq(expected) 
#   }

  check_outline("Inbox", doc)
  check_outline("Library", doc)
end

def check_outline(name, doc)
  nodes = doc.xpath("//outline[@text='" + name + "']")
  nodes[0]["text"].should eq(name)

  nodes[0].element_children.each_with_index { |item, i| 
#     actual = item["text"]
#     expected = @inbox_tasks[i]["name"]
#     actual.should eq(expected) 
    check_value(item, i, "text", "name")
    check_value(item, i, "url", "url")
    check_value(item, i, "created", "created")
  }  
end

def check_value(item, i, opml_key, json_key)
    actual = item[opml_key]
    expected = @inbox_tasks[i][json_key]
    actual.should eq(expected) 
end