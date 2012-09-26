Feature: Export OmniFocus to OPML
As an OmniFocus user
I want export my OmniFocus content as OMPL format
So that I can visualise my work in a tool that supports this format

#Scenario: inbox is empty, library is empty
#  Given that OmniFocus contains this content
#     | Name | Location | Link |
#  When I export my OmniFocus content to OPML
#  Then I see an OPML representation of my OmniFocus content

Scenario: inbox has items, library is empty
  Given that OmniFocus contains this content
     | Name | Location | Link | Created |
     | Confirm reservation at restaurant | Inbox | url1 | 2012-09-26 00:10:01 |
     | Call Bob | Inbox | url2 | 2012-08-01 08:13:11 |
  When I export my OmniFocus content to OPML
  Then I see an OPML representation of my OmniFocus content


#Scenario: export to OPML
#  Given that OmniFocus contains this content
#     | Name | Location | Link |
#     | Confirm reservation at restaurant | Inbox | url1 |
#     | Read slogger readme | Personal > Setup Slogger | url2 |
#     | Discuss workflow with team | Work > Setup kanban board with team | url3 |
#  When I export my OmniFocus content to OPML
#  Then I see an OPML representation of my OmniFocus content
