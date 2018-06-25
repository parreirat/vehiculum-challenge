Current priority: 5

####Priorities:
~~1 - Implement all the Status::Page classes.~~ **15 minutes**

~~2 - Implement tests for all the Status::Page classes.~~ **5 minutes**
  - Simply copy/pasting tests around: can be generalized into a
    meta-programming test class (like a lot of the code we'll have in this
    task) that will do everything by itself, but I've grown somewhat weary of
    doing too much meta-programming magic as time goes on because suddenly
    things might start specializing and then... a lot of unnecessary work.

~~3 - Implement tests for Status::DataStore.~~ **80 minutes**
  - Wasting way too much time on "what's the best standards of test making I can
    have?", for example on focusing on not having more than one expectation per
    example.
  - Also struggled with how to test for file input/output, have never
    dealt with it.
  - Struggled with stubbing the files for this and cleaning them.
  - Stuck for last 30 minutes figuring out why the time stamps on my backed
    up/loaded data always changes by fractions of a second.
    expected: {...[{..., :time=>2018-06-25 17:57:29.000000000 +0100}]...}
         got: {...[{..., :time=>2018-06-25 17:57:29.438726313 +0100}]...}
  - Solved after about 1 hour: the first thing I looked and kept looking at
    all the time, our 'Time.now' for introducing random data points, was
    introducing the lesser-than-second units which were not visible in Time
    object without accessing it directly into comparison. Use Time#round to
    eliminate lesser-than-second fractions.
  - Now big comparisons are still failing comparisons in very very rare cases,
    and no miliseconds are involved now. Taking a break.
  - Fixed in 5 minutes: sorting by all the tuples makes the sorting as expected.
  - 2 more minutes to add one final tests for Status::DataStore. (tests in
    need of refactoring, too much repetition throughout this one)

~~4 - Implement tests for Status::History.~~
  - Not much to do here: could create a fixture table generated from a fixed set
    of seeds. Would create an identical data store, create the same data points,
    and expect the print to be exactly the same as that of the fixture table
    output.
  - Stopping for now.

####Checklist:
[x] - Tests **100 minutes total**
  [x] - Status::Page **5 minutes**
    [x] - Status::Page::Bitbucket
    [x] - Status::Page::Cloudflare
    [x] - Status::Page::Github
    [x] - Status::Page::Rubygems
  [x] - Status::DataStore **80 minutes**
  [x] - Status::History **15 minutes**

[x] - Implementation **15 minutes total** (post-Bitbucket)
  [x] - Status::Page
    [x] - Status::Page::Bitbucket (included in 1h10 with basic CLI pull)
    [x] - Status::Page::Cloudflare
    [x] - Status::Page::Github
    [x] - Status::Page::Rubygems

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
    [ ] - with reset/smash/wipe argument
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - stats
  [ ] - IMPROVEMENTS
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[ ] - sparks
  [ ] - yields for formatting .csv data outputs
  [ ] - rake task for basic implementation of new Status::Page
  [ ] - rake tasks/config file for new pages to be implemented
  [ ] - release actual gem

[ ] - General refactor
  [ ] - Rubocop linting
  [ ] - Comment cleanup/uniformization
  [ ] - Use optimist gem versions or lock them

####Notes
Not sure what this refers to exactly, in the task PDF:
  - Store error messages of status pages (ex. Minor Service Outage) display them later.
Very little experience with Docker, not sure what this one refers to either:
  - Use Docker to generate an image which can accept different arguments for
different processes.
