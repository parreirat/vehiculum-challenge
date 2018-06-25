RSpec.describe Status::Pages::Rubygems do

	# Same as calling 'subject' due to describe having class, but I like
	# being explicit
	let(:klass) { Status::Pages::Rubygems }
	let(:page)  { klass.new }

	it "has a defined PAGE_URL constant" do
		expect(klass.const_defined?(:PAGE_URL)).to be_truthy
	end

	it "has a defined #page_url method" do
		expect(klass.new.respond_to?(:page_url)).to be_truthy
	end

	it "has a defined PROVIDER constant" do
		expect(klass.const_defined?(:PROVIDER)).to be_truthy
	end

	it "has a defined #provider method" do
		expect(klass.new.respond_to?(:provider)).to be_truthy
	end

	it "has overriden #is_up? method" do
    VCR.use_cassette("up_rubygems") do
			# Have to think about this: false positives... (checking specific error)
			expect{ page.is_up? }.to_not raise_error(NotImplementedError)
		end
	end

	# Redundant? Calls #!is_up?
	it "has overriden #is_down? method" do
    VCR.use_cassette("up_rubygems") do
			expect{ page.is_down? }.to_not raise_error
		end
	end

	it "has nil @html_body before any requests are made" do
		expect(page.html).to be_nil
		expect(page.parsed_html).to be_nil
	end

	it "has non-nil @html and @parsed_html after request to webpage" do
    VCR.use_cassette("up_rubygems") do
    	# For testing purposes, not supposed to be called directly.
			page.send(:request_page)
			expect(page.html).to_not be_nil
			expect(page.parsed_html).to_not be_nil
		end
	end

	it "checks that the webpage is up correctly" do
    VCR.use_cassette("up_rubygems") do
			expect(page.is_up?).to be_truthy
		end
	end

end
