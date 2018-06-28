# Status

Simple Plain Ruby that pools a given set of webpages for their up or down
status and writes it to a local data store (in the form of a default file).

Allows you to continuously pool the status of a set of webpages' statuses with
`live` or `stats pull` for a single pool.

You can also backup the current data store to a file of your choice with
`stats backup`, or `stats restore` from a previously done backup. (the files
are simply `.csv` files, human-readable)

Print out the history in a pretty table of the data store with `status history`.

You can also call `stats reset` to delete the data store.

## Installation

We do not have a published gem, hence installation will be exclusively through
the  Development section below.

## Development

Start off by cloning our repository into your machine:
`git clone https://github.com/parreirat/vehiculum-challenge`

Follow by running `bin/setup`, which will install dependencies.

Now you have two ways of **installing** the gem:

1 - Now you can build a local-version of our gem by running `rake build`, and
then running `gem install status-x.x.x"` (you can omit the version if not
necessary).

2 - Or just run the following command:
`bundle exec rake install`

**Now there's an important step**: depending on how you have your rubies set
up, you might have to do something different: I use `rbenv`, so I have to call
`rbenv rehash`, you won't get the global executable working otherwise.

If you want to **reinstall** the gem due to changes or other reasons, run
`gem uninstall status`, and repeat step 1, or rerun command from step 2.

After installing the gem you will now have global access to our `status`
executable ruby file, which our Status CLI Tool made with `thor`.
So you will be able to call `status command` wherever in your bash.

You can run `bin/console` for an interactive `Pry` console with some debugging
goodies.
  - `awesome_print`: with which you can call `ap any_object` for a very
    useful, color-formatted object output which facilitates development.
  - `pry`: you can insert `binding.pry` anywhere into the code and get an
    interactive console to stop when executing hits that call, among other
    things, call `help` while in a Pry console.
    Read more: https://github.com/pry/pry
  - `pry-byebug`: adds step-by-step debugging and stack navigation capabilities
    to the interactive console, using commands uch as `step`, `next`...
    Read more here: https://github.com/deivid-rodriguez/pry-byebug
  - `pry-doc`: extends the available documentation in a Pry console through
    the usage of the `show-doc` and `show-source` commands.
    Read more: https://github.com/pry/pry-doc
  - `pry-rescue`: allows you to execute ruby executables by prepending `rescue`,
    ex. with `guard` + `rspec` (very useful for fast and dynamic test making),
    and also surround blocks of code with `Pry.rescue {...}`, which will
    initiate an interactive Pry console wherever an unhandled exception was
    raised.
    Read more: https://github.com/ConradIrwin/pry-rescue
  - `pry-stack_explorer`: adds some more state and code navigation capabilities
    akin to `pry-byebug`.
    Read more: https://github.com/pry/pry-stack_explorer

After checking out the repo, run `bin/setup` to install dependencies.
For running tests, I recommend using `guard`, which is configured, along with
`pry-rescue`.

To execute `rspec` tests without `guard`:
`bundle exec rspec`

To execute `rspec` with `guard`:
`bundle exec guard` - (you can add a useful `-c` flag to clear on new tests)

To execute `rspec` with `guard` and `pry-rescue` so any failing tests stops at
the failing point you will need to call the above command with an ENV_VAR,
defined in `Guardfile` in the project root. So you'd need to do:
`ENABLE_GUARD_RESCUE=true bundle exec guard -c` (now with our clear flag)

To facilitate this I created two aliases in my local machine in `~.bash_aliases`:
alias `rescue_guard="ENABLE_GUARD_RESCUE=true bundle exec guard -c"`
alias `no_rescue_guard="bundle exec guard -c"`

So you can get the rests running with one command, explicitly using `guard` with
or without `pry-rescue`: up to personal preference.

## Sample test run

After installation in order to exemplify usage, follow this workflow.

I suggest running three tabs in addition to the one you're invoking `status` on with the following commands each in order to quickly see the data stores at work:

`watch -d -n 0.25 "cat default_data_store.csv"`

`watch -d -n 0.25 "cat backup_data_store.csv"`

`watch -d -n 0.25 "cat my_pretty_file.csv"`

Don't know how your bash/terminal is set up, but I prepared the big block of calls below to be copy-pasted straight into the console for a complete run through all of the CLI tool's working features.

I inserted a lot of sleeping calls where I deemed logic in case you want to stop after each significant command to verify what's changing in the data stores and terminal.

Modify the SLEEPING TIME variable below to any number you'd like.
`SLEEPING_TIME=0` will disable any sleeps.

``` 
SLEEPING_TIME=10
status history
sleep $SLEEPING_TIME
status pull
sleep $SLEEPING_TIME
status pull --no-output
sleep $SLEEPING_TIME
status pull --no-output --webpages bitbucket github
sleep $SLEEPING_TIME
status pull --webpages cloudflare github
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status backup
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status reset
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status restore
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status reset
sleep $SLEEPING_TIME
status pull --webpages rubygems github
sleep $SLEEPING_TIME
status pull --webpages cloudflare github bitbucket
sleep $SLEEPING_TIME
status pull --webpages cloudflare rubygems
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status backup --file=my_pretty_file.csv
sleep $SLEEPING_TIME
status reset
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status restore --file=my_pretty_file.csv
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status reset
status pull --webpages rubygems
status pull --webpages rubygems
status pull --webpages rubygems
status pull --webpages rubygems
status backup --file=my_pretty_file.csv
sleep $SLEEPING_TIME
status reset
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status pull --webpages cloudflare
status pull --webpages cloudflare
status pull --webpages cloudflare
status pull --webpages cloudflare
status history
sleep $SLEEPING_TIME
######### With the restore below you can see restore merging data
status restore --file=my_pretty_file.csv
sleep $SLEEPING_TIME
status history
sleep $SLEEPING_TIME
status live --pool_interval=2 --webpages github cloudflare bitbucket
```

**Now ctrl-C to interrupt status live whenever and all the CLI tool
interactions have been shown.**

## Usage

`status pull` -
  For no output:
  `status pull --no-output`
  For a subset of webpages:
  `status pull --webpages github bitbucket`

`status live` -
  For no output
  `status live --no-output`
  
  For a subset of webpages:
  `status live --webpages github bitbucket`
  
  To specify seconds interval after pooling a set of webpages (default 5 seconds):
  `status live --pool_interval=2`

`status history` - Prints out a history of data store, no arguments.

`status backup` -
  Just pass in the file name as argument:
  `status backup --file=my_pretty_file.csv`
  Not specifying a file will use `backup_data_store.csv` by default.

`status restore` -
  Just pass in the file name as argument:
  `status restore --file=my_pretty_file.csv`
  Not specifying a file will use `backup_data_store.csv` by default.

`status reset` - Wipes data store.

`status stats` - Not implemented as of now.

`status share` - Not implemented as of now.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
