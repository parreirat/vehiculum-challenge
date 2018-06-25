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

end
