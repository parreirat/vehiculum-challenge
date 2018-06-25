module Status
	module Pages
		class Bitbucket < Page

			UP_STRING = "Operational".freeze
			PAGE_URL  = "https://status.bitbucket.org/".freeze
			PROVIDER  = :bitbucket.freeze

			def page_url
				PAGE_URL
			end

      def provider
        PROVIDER
      end

      # Checks our webpage's HTML through some selectors using the goa gem.
			def is_up?(save_data = true)
				# Set our parsed_html and html.
				request_page
			  # @parreirat NOTE - Not the most robust thing if the page layout
			  #   changes but what else? No constant IDs, classes... just structure.
      	is_up = parsed_html.css('.component-inner-container')[0]
                           .css('.component-status')
                           .text.strip == UP_STRING
        status = is_up ? :up : :down
        save_new_data(provider, status, Time.now) if save_data
        is_up
			end

		end
	end
end