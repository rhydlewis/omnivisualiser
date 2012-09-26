Feature: Export OmniFocus to OPML
As an OmniFocus user
I want export my OmniFocus content as OMPL format
So that I can visualise my work in a tool that supports this format

Scenario: inbox is empty, library is empty
  Given that OmniFocus contains this content
    | Task Name | Task Link | Task Created | Parent Location | Parent Link | Parent Created |
  When I export my OmniFocus content to OPML
  Then I see an OPML representation of my OmniFocus content

Scenario: inbox has items, library is empty
  Given that OmniFocus contains this content
    | Task Name | Task Link | Task Created | Parent Location | Parent Link | Parent Created |
    | Confirm reservation at restaurant | url1 | 26/09/2012 00:10:01 | Inbox |  |  |
    | Call Bob | url2 | 01/08/2012 08:13:11 | Inbox |  |  |
  When I export my OmniFocus content to OPML
  Then I see an OPML representation of my OmniFocus content

Scenario: export to OPML
  Given that OmniFocus contains this content
    | Task Name | Task Link | Task Created | Parent Location | Parent Link | Parent Created |
    | Confirm reservation at restaurant | url1 | 26/09/2012 00:10:01 | Inbox |  |  |
    | Call Bob | url2 | 01/08/2012 08:13:11 | Inbox |  |  |
    | Read slogger readme | url3 | 02/07/2012 01:11:15 | Personal > Setup Slogger | url5 | 01/07/2012 02:01:15 |
    | Discuss workflow with team | url4 | 05/08/2012 11:11:11 | Setup kanban board with team | url6 | 04/08/2012 11:11:11 |
  When I export my OmniFocus content to OPML
  Then I see an OPML representation of my OmniFocus content
