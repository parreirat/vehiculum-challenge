module Status
  module Pages
    class __class_name__ < Page

      PAGE_URL  = "__page_url__".freeze
      PROVIDER  = :__provider_name__.freeze

      def page_url
        PAGE_URL
      end

      def self.provider
        PROVIDER
      end

      def provider
        self.class.provider
      end

      def is_up?(save_data = true)
        request_page
        is_up = is_page_up?
        status = is_up ? :up : :down
        save_new_data(provider, status, Time.now) if save_data
        is_up
      end

      # You can access the variable 'html' for the raw page html,
      # or 'parsed_html' for the goa-parsed object of 'html'.
      # Check https://github.com/YorickPeterse/oga for more information how
      # to use oga gem to manipulate 'parsed_html'.
      # Example to get the text from the first node with class '.status':
      #   parsed_html.css(".status")[0].text
      # You can chain these just like jQuery:
      #   parsed_html.css(".status").css(".text-description")[0].text
      #
      # vvvvvvvvvvvvvvvvvv
      # html.match(//)
      # parsed_html.css()
      # ^^^^^^^^^^^^^^^^^^
      #
      # Should return true if page is up, false otherwise.

      # def is_page_up?
      # end

    end
  end
end