require "net/http"

module Status
	class Page

		# Raw HTML from request.
		attr_accessor :html
		# GOA-parsed object.
		attr_accessor :parsed_html
		# All classes descending from < Page, in other words, our implemented pages.
		attr_accessor :implemented_pages
		# Our Data::Store, to store data when we receive status information.
		attr_accessor :data_store

		# Make inherited classes add to this classes' descendants.
		def self.inherited(subclass)
			# @parreirat TODO - This never runs for the status executable when
			# outside the project root... no idea why. Fix this.
			# binding.pry
		  (@implemented_pages ||= []) << subclass
		end

		def self.implemented_pages
			@implemented_pages
		end

		def data_store
			@data_store ||= Status::DataStore.new
		end

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

			def save_new_data(provider, status, time)
				data_store.add_data_point(provider, status, time)
				data_store.save_data_store
			end

			def request_page
				uri          = URI.parse(page_url)
				@html        = Net::HTTP.get(uri)
				@parsed_html = Oga.parse_html(@html)
			end

	end
end