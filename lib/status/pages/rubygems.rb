module Status
  module Pages
    class Rubygems < Page

      UP_STRING = "All Systems Operational".freeze
      PAGE_URL  = "https://status.rubygems.org/".freeze
      PROVIDER  = :rubygems.freeze

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
        is_up = parsed_html.css(".page-status .status")[0]
                           .text.strip == UP_STRING
        status = is_up ? :up : :down
        save_new_data(provider, status, Time.now) if save_data
        is_up
      end

    end
  end
end