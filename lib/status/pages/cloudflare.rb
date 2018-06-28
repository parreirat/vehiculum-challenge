module Status
	module Pages
		class Cloudflare < Page

      # @parreirat NOTE - Found a bug where we report cloudflare as down.
      # Upon loading as of this time, for about 1/5th of a second, the text
      # shows as "Minor Service Outage" with a yellow-colored background and
      # a few other page differences.
      # It then reverts to what we expect... what to do? Is this considered
      # up or down? How would we check the "final result", it's clearly some
      # post-load JS.
      UP_STRING = "All Systems Operational".freeze
      PAGE_URL  = "https://www.cloudflarestatus.com/".freeze
      PROVIDER  = :cloudflare.freeze

      def page_url
        PAGE_URL
      end

      def self.provider
        PROVIDER
      end

      def provider
        self.class.provider
      end

      # Checks our webpage's HTML through some selectors using the goa gem.
      def is_up?(save_data = true)
        # Set our parsed_html and html.
        request_page
        is_up = parsed_html.css('.page-status')[0].text.strip == UP_STRING
        status = is_up ? :up : :down
        save_new_data(provider, status, Time.now) if save_data
        is_up
      end

		end
	end
end