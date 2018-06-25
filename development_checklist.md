Current priority: 2

####Priorities:
~~1 - Implement all the Status::Page classes.~~ **** 15 minutes
2 - Implement tests for all the Status::Page classes.
3 - Implement tests for Status::DataStore.
4 - Implement tests for Status::History.

####Checklist:
[ ] - Tests
  [ ] - Status::Page
    [x] - Status::Page::Bitbucket
    [ ] - Status::Page::Cloudflare
    [ ] - Status::Page::Github
    [ ] - Status::Page::Rubygems
  [ ] - Status::DataStore
  [ ] - Status::History

[x] - Implement Status::Page::Bitbucket
[x] - Implement Status::Page::Cloudflare
[x] - Implement Status::Page::Github
[x] - Implement Status::Page::Rubygems

[x] - pull
  [x] - with output argument
  [x] - with data storage saving
  [ ] - IMPROVEMENTS
    [ ] - with webpages argument
    [ ] - with thread usage
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - live
  [x] - with output argument
  [x] - with pool_interval argument
  [x] - with data storage saving
  [ ] - IMPROVEMENTS
    [ ] - with webpages argument
    [ ] - with thread usage
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - history
  [ ] - IMPROVEMENTS
    [ ] - with max_entries argument
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - backup
  [ ] - IMPROVEMENTS
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - restore
  [ ] - with MERGE instead of replace
  [ ] - IMPROVEMENTS
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - stats
  [ ] - IMPROVEMENTS
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - sparks
  - TODO

[ ] - Comment cleanup

[ ] - General refactor

####Notes
Not sure what this refers to exactly, in the task PDF:
  - Store error messages of status pages (ex. Minor Service Outage) display them later.
