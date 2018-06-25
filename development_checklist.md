Current priority: 3

####Priorities:
~~1 - Implement all the Status::Page classes.~~ **** 15 minutes

~~2 - Implement tests for all the Status::Page classes.~~ 5 minutes
  - Simply copy/pasting tests around: can be generalized into a
    meta-programming test class (like a lot of the code we'll have in this
    task) that will do everything by itself, but I've grown somewhat weary of
    doing too much meta-programming magic as time goes on because suddenly
    things might start specializing and then... a lot of unnecessary work.

3 - Implement tests for Status::DataStore.

4 - Implement tests for Status::History.

####Checklist:
[ ] - Tests
  [x] - Status::Page
    [x] - Status::Page::Bitbucket
    [x] - Status::Page::Cloudflare
    [x] - Status::Page::Github
    [x] - Status::Page::Rubygems
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
