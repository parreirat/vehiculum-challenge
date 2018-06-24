###Breakdown of tasks:

- Initial bundle gem setup, development gems and tweaks, github repo: **15 minutes**
^20 minutes -> wasted time trying to hide bash prompt and making method to
restore it, paths getting too big in terminal for my little resolution

- Setup basic working Thor console: **15 minutes**
^10 minutes -> Still need to see how arguments and optional arguments are handled: had to go out for lunch at this point, unexpected interruption
^20 minutes -> Changing namespaces, modules and everything else took some work.
Initial problem was that our bin/status wasn't appending '/lib' onto the
$LOAD_PATH, therefore we'd have to do some sleazy requires. Figured out I forgot the 'bundler_setup' require in order to have .gemspec execute and append it
properly.

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


