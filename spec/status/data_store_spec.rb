RSpec.describe Status::DataStore do

  # Generated with: Status::DataStore.new.send(:empty_data_store)
  DEFAULT_DATA_STORE_HASH = {
    cloudflare: [],
    github:     [],
    bitbucket:  [],
    rubygems:   []
  }

  # @parreirat NOTE - Should add in ffaker gem or similar to generate
  # sample data. Should also use helper modules perhaps.
  # Generate some random data points for our current data store.
  def add_random_data_point(data_store, provider)
    # DEFAULT_DATA_STORE_HASH.keys.sample
    data_point_args = [
      provider,
      [:up, :down].sample,
      Time.now - Random.rand(100)
    ]
    data_store.add_data_point(*data_point_args)
    data_point_args
  end

  # Use 'rspec_data_store.csv' as our stub, which means within all our tests
  # the used data store file will be this one.
  before(:each) do
    allow_any_instance_of(Status::DataStore).to receive(:default_file)
                                            .and_return("rspec_data_store.csv")
  end

  # Clean our data stores after every test.
  after(:each) do
    # data_store.wipe_data_store if data_store
  end

  let(:klass) { Status::DataStore }
  # Pass in false to never load the default files, just initialize.
  let(:data_store) { Status::DataStore.new(false) }

  it "initializes with a default data hash" do
    expect(data_store.data).to_not be_nil
  end

  # This will by default check if data is a Hash.
  it "initializes with a default data hash of correct format" do
    expect(data_store.data).to eq(DEFAULT_DATA_STORE_HASH)
  end

  # @parreirat NOTE - Isn't this somewhat... redundant?
  context "adding data points for all providers" do
    DEFAULT_DATA_STORE_HASH.keys.each do |provider|

      let(:random_data_point) {
        add_random_data_point(data_store, provider)
        data_store.data[provider][0]
      }

      it "#{provider} - increases provider's data store point count" do
        add_random_data_point(data_store, provider)
        expect(data_store.data[provider].length).to eq(1)
      end

      it "#{provider} - data point stored has :status and :time keys" do
        # Sort so the order does not matter.
        expect(random_data_point.keys.sort).to eq([:status, :time].sort)
      end

      it "#{provider} - stored data point's :status is a Symbol value" do
        expect(random_data_point[:status]).to be_a(Symbol)
      end

      it "#{provider} - stored data point's :time is a Time value" do
        expect(random_data_point[:time]).to be_a(Time)
      end

      it "throws an error if adding a data point with a non-Symbol :provider" do
        args = ["string", :up, Time.now]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

      it "throws an error if adding a data point with a non-Symbol :status" do
        args = [provider, "string", Time.now]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

      it "throws an error if adding a data point with a non-Time :time" do
        args = [provider, :up, "string"]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

    end

  end

end
