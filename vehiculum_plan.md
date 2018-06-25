###Additional sparks while doing actual coding:

- Be able to scout several of the services within each web page, not only if the main service is operational.

###Breakdown of tasks:

- Initial bundle gem setup, development gems and tweaks, github repo: **15 minutes**
^20 minutes -> wasted time trying to hide bash prompt and making method to
restore it, paths getting too big in terminal for my little resolution

- Setup basic working Thor console: **15 minutes**
^10 minutes -> Still need to see how arguments and optional arguments are handled: had to go out for lunch at this point, unexpected interruption
^20 minutes -> Changing namespaces, modules and everything else took some work.
Initial problem was that our bin/status wasn't appending '/lib' onto the
$LOAD_PATH, therefore we'd have to do some sleazy requires. Figured out I forgot the 'bundler_setup' require in order to have .gemspec execute and append it properly.

- Setup of barebones proposed objects and their requires (have everything checked to be loading correctly in console): **15 minutes**
	- **Pages**
		-- **Page::Bitbucket**
		-- **Page::CloudFlare**
		-- **Page::Rubygems**
		-- **Page::Github**
	- **History**
	- **DataStore**
^15 minutes -> Also configured bin/console here.

- starting for a **Page::Bitbucket**:
	- working **pull**, querying URL and outputting status: **20 minutes**
	- working **pull**, saving data to **DataStore**: **30 minutes**
	- working **pull** through CLI: **10 minutes**
	- working **live** through CLI: **20 minutes** (uses pull)
	- tests: use **vcr** gem with casette for mock requests: **20 minutes**
- fill in other **Page::Webpage** objects, get the respective tests and check if all is working: **30 minutes**

^-> Done basic pull with output through CLI, with tests for VCR but no datastore in ~1h10. A few distractions but generally just a lot of tweaking and moving around of methods and figuring how to do things better. Taking a break.

- working **history**, through CLI, with **terminal-table** gem: **20 minutes**
- tests: **10 minutes**

- working **backup** to **.csv** working: **15 minutes**
- working **restore** from **.csv** working: **15 minutes**
	- Make sure the restore works by appending rather than replacing as per Bonus goal
- get both **backup** and **restore** working from CLI Command: **15 minutes**
- tests: **10 minutes**

- working  **stats**: **30 minutes**
- tests: **10 minutes**

- refactor, finishing touches: **30 minutes**

Over the course of about 2ish hours, possibly 2h30 implemented DataStore,
History, CLI commands for pull/live/history, but not backup/restore (trivial).
Took this long due to a lot of time just playing around with implementations
and different ways of doing things, as well as a LOT of wasted time of figuring
the "most correct way" of doing descriptions and method options with Thor.
- "Use method_options for everything? Use arguments? Why are there arguments
if there's method_options and they seem to cover all the cases?"
- "How do I do the description of the CLI Commands? How do I specify the
arguments or outputs?"
Need a top-level orchestrator class which the CLI commands will simply call,
where internals are done.

Should have done a proper checklist of the tasks, and crossed them out in the
.md somehow as I went on, and wrote down the times in a more organized fashion.
Found it hard to just follow the tasks sequentially because I was having fun
and forgot to follow the order of tasks and write down the times, as well as
doing the small commits.

Will elaborate a checklist.md instead.