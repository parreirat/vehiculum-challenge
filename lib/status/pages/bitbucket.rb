module Status
	module Pages
		class Bitbucket < Page

			UP_TEXT     = "Operational".freeze
			WEBPAGE_URL = "https://status.bitbucket.org/".freeze

			def page_url
				WEBPAGE_URL
			end

			def is_up?
				# Set our parsed_html and html.
				request_page!
			  # Not the most robust thing if the page layout changes but...
      	parsed_html.css('.component-inner-container')[0]
                   .css('.component-status')
                   .text.strip == UP_TEXT
			end

		end
	end
end