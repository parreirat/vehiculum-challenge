###Breakdown of tasks:

- Initial bundle gem setup, development gems and tweaks, github repo: **15 minutes**

^5 minutes

- Setup basic working Thor console: **15 minutes**

- Setup of barebones proposed objects and their requires (have everything checked to be loading correctly in console): **15 minutes**
	- **Page**
		-- **Page::Bitbucket**
		-- **Page::CloudFlare**
		-- **Page::Rubygems**
		-- **Page::Github**
	- **History**
	- **DataStore**

- starting for a **Page::Bitbucket**:
	- working **pull**, querying URL and outputting status: **20 minutes**
	- working **pull**, saving data to **DataStore**: **30 minutes**
	- working **pull** through CLI: **10 minutes**
	- working **live** through CLI: **20 minutes** (uses pull)
	- tests: use **vcr** gem with casette for mock requests: **20 minutes**
- fll in other **Page::Webpage** objects, get the respective tests and check if all is working: **30 minutes**

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


