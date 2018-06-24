require "net/http"

module Status
	class Page

		# WEBPAGE_URL - should be overridden by inheriting classes.

		attr_accessor :html        # Raw HTML from request.
		attr_accessor :parsed_html # GOA-parsed object.

		# def self.pages
		#   descendants = []
		#   ObjectSpace.each_object(Status::Page.singleton_class) do |k|
		#       descendants.unshift k unless k == self
		#   end
		#   descendants
		# end

		def page_url
			raise NotImplementedError,
				"Implement in inheriting pages, ex. Status::Page::Bitbucket.page_url?"
		end

		def is_up?
			raise NotImplementedError,
				"Implement in inheriting pages, ex. Status::Page::Bitbucket.is_up?"
		end

		def is_down?
			!is_up?
		end

		private

			def request_page!
				uri          = URI.parse(page_url)
				@html        = Net::HTTP.get(uri)
				@parsed_html = Oga.parse_html(@html)
			end

	end
end