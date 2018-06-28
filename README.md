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
## Usage

`status pull` -

`status live` -

`status history` -

`status backup` -

`status restore` -

`status reset` -

`status stats` -

`status share` -


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).