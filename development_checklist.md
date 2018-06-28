Didn't manage to finish this today again. 2h30m went just into organizing
some things, unthreading main branch and branching the threaded future-fixes,
making the gem properly install and symlink executable, elaborate README.md
(still missing usage instructions), and some other misc. things.
Will do a final stretch tomorrow.

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

~~4 - Implement tests for Status::History.~~ **15 minutes**
  - Not much to do here: could create a fixture table generated from a fixed set
    of seeds. Would create an identical data store, create the same data points,
    and expect the print to be exactly the same as that of the fixture table
    output. Drifted a bit thinking about doing actual output testing and gave
    up.
  - Stopping for now.

~~5 - Implement CLI command backup~~ **5 minutes**
~~6 - Implement CLI command restore~~ **5 minutes**
  - Just needed to call implemented methods on both, done in 10 minutes.

~~7 - Fix duplicates on 'restore' command merge.~~ **5 minutes**
  - Just squash duplicates with uniq after each restore.

~~8 - Implement webpages argument into pull~~ **20 minutes**
  - Starting refactoring and aborting... then deciding to refactor again... and
    aborting again. Not very pretty code on pull and futurely live.

~~9 - Implement webpages argument into live~~ **30 minutes**
    - Supposed to be 2 minutes. Playing around with threads and mutexes for thread
      safety despite nothing having blown yet (pooling with threads)
    - Stopping for now.

~~10 - Configure library to be set up as a gem~~ **2h30m**
  - Have never done this and I really felt like tackling it - I feel like I did
    everything right right off, but ran into a `require` issue and then every
    time I was redoing the instructions, could never get `status` to be
    available as an executable. After a lot of gem reinstalls, rbenv rehashes,
    remaking of symbolic links and a final reboot I managed to get it working
    again.
  - I knew my absolute path requires in `lib/status/pages` would bite back
    eventually. :)


11 - Implement CLI command stats

####Checklist:

[x] - Tests **100 minutes total**
  [x] - Status::Page **5 minutes**
    [x] - Status::Page::Bitbucket
    [x] - Status::Page::Cloudflare
    [x] - Status::Page::Github
    [x] - Status::Page::Rubygems
    [ ] - IMPROVEMENTS
      [ ] - Duplicated VCR.use_casettes, use blocks to define
  [x] - Status::DataStore **80 minutes**
    [ ] - IMPROVEMENTS
      [ ] - Should stub entire test suite for DataStore's default_file, some tests are leaking into it.
  [x] - Status::History **15 minutes**
  [ ] - IMPROVEMENTS
    [ ] - Should use ".class_method", "#instance_method" notations.

[x] - Implementation **15 minutes total** (post-Bitbucket)
  [x] - Status::Pages
  [x] - Status::Page
    [x] - Status::Page::Bitbucket (included in 1h10 with basic CLI pull)
    [x] - Status::Page::Cloudflare
    [x] - Status::Page::Github
    [x] - Status::Page::Rubygems
  [x] - Status::DataStore
    [ ] - IMPROVEMENTS
      [ ] - If running a 'live' writing to CSV should only append
  [x] - Status::History

[x] - pull
  [x] - with output argument
  [x] - with data storage saving
  [ ] - IMPROVEMENTS
    [x] - with webpages argument **20 minutes** (starting refactoring and aborting...)
    [x] - with thread usage
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - live
  [x] - with output argument
  [x] - with pool_interval argument
  [x] - with data storage saving
  [ ] - IMPROVEMENTS
    [x] - with webpages argument **2 minutes**
    [x] - with thread usage (hmm there have to be thread-safety issues here...
          nothing blew up yet though) - **28 minutes**
      [ ] - may blow up: use 'concurrent' with locks on thread-unsafe code
            (writes to files? access to instance variables?)
    [ ] - pool_interval should technically be interval between requests?
    [ ] - each thread should continuously pool the webpage, not wait for others
          before repooling
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - history **5 minutes**
  [ ] - IMPROVEMENTS
    [x] - with format argument **2 minutes**
    [ ] - with max_entries argument
    [ ] - with error handling
    [ ] - with webpages argument (print out history for certain pages)
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - backup **5 minutes**
  [ ] - IMPROVEMENTS
    [ ] - with error handling
    [ ] - with internals hidden away
    [ ] - prettify/uniformize description/argument usage

[x] - restore **5 minutes**
  [ ] - IMPROVEMENTS
    [x] - with MERGE instead of replace **2 minutes** (just add option)
      [x] - do not add duplicates on merge **5 minutes**
    [x] - with reset/smash/wipe argument **2 minutes**
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
  [ ] - yields for formatting history table outputs
  [ ] - rake task for basic implementation of new Status::Page
  [ ] - rake tasks/config file for new pages to be implemented
  [-] - release actual gem
    - Not gonna polute the rubygems repository with this, dumb idea.
  [ ] - history should list by webpage argument as well
  [ ] - `share` uses some web API to put up a file with the "history" output
        or something similar, returns a link directly to the CLI

[ ] - General refactor
  [ ] - Top-level Command class to be called by Status CLI class
  [ ] - Rubocop linting
  [ ] - Comment cleanup/uniformization
  [ ] - Use optimist gem versions or lock them
  [x] - Configure gemspec for gem install to set up all the systemwide
        executables
  [ ] - Didn't get around to asking about time zone handling: defaulting to +0100, written to data store.
  [ ] - Implement bin/setup: do bundle, bundle exec rake install rake task invoke, and rbenv rehash if rbenv is defined. Check if status is available directly on project root after.

####Notes

Not sure what this refers to exactly, in the task PDF:
  - Store error messages of status pages (ex. Minor Service Outage) display them later.
Very little experience with Docker, not sure what this one refers to either:
  - Use Docker to generate an image which can accept different arguments for
different processes.

Did not use branching for development at all - bad!

I think I should have kept the DataStore data point format as is in CSV, just
arrays of arrays, would facilitate some things a lot.