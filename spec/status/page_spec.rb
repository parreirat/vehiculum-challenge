RSpec.describe Status::Page do

	IMPLEMENTED_PAGES = [
		Status::Pages::Cloudflare,
		Status::Pages::Github,
		Status::Pages::Bitbucket,
		Status::Pages::Rubygems
	]

	it "defines a implemented_pages method" do
		expect(Status::Page).to respond_to(:implemented_pages)
	end

  it "implemented_pages returns all pages' classes correctly" do
		expect(Status::Page.implemented_pages).to eq(IMPLEMENTED_PAGES)
  end

  it "does not blow up - is thread-safe!" do
  	expect {
		  1.times do
		    threads = []
		    Status::Page.implemented_pages.each do |klass|
		      provider = klass.to_s.split("::").last.capitalize
		      threads << Thread.new do
		        page = klass.new
		        puts "Pooling #{provider}...".yellow
		        # WebMock.allow_net_connect!
		        # VCR.turn_off!
		        is_up = nil
		        VCR.use_cassette("up_#{provider}") do
		          is_up = page.is_up?(true)
		        end
		        # VCR.turn_on!
	          status = ""
	          if is_up
	            status = "Up!".to_s.green
	          else
	            status = "Down!".to_s.red
	          end
	          puts "Pooling #{provider} complete: #{status}".yellow
		      end#.join # If we join here, it's multi-threaded one at a time
		    end
		    # Wait for all of our threads.
		    threads.each(&:join)
		  end
		}.to_not raise_error
	end

end
