RSpec.describe Status::DataStore do

  RSPEC_DATA_STORE_FILE = "rspec_data_store.csv"
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
      Time.now.round - Random.rand(7200)
    ]
    data_store.add_data_point(*data_point_args)
    data_point_args
  end

  # Use 'rspec_data_store.csv' as our stub, which means within all our tests
  # the used data store file will be this one.
  before(:each) do
    data_store.wipe_data_store
    allow_any_instance_of(Status::DataStore).to receive(:default_file)
                                            .and_return(RSPEC_DATA_STORE_FILE)
  end

  # Clean our data stores after every test.
  after(:each) do
    data_store.wipe_data_store
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

  it "initializes with no data store file" do
    data_store # initialize our object
    expect(File.exists?(data_store.default_file)).to be_falsey
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
        args = ["string", :up, Time.now.round]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

      it "throws an error if adding a data point with a non-Symbol :status" do
        args = [provider, "string", Time.now.round]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

      it "throws an error if adding a data point with a non-Time :time" do
        args = [provider, :up, "string"]
        expect{ data_store.add_data_point(*args) }.to raise_error(ArgumentError)
      end

    end

    let(:provider) { DEFAULT_DATA_STORE_HASH.keys.sample }

    it "#save_data_store creates the data store file" do
      add_random_data_point(data_store, provider)
      data_store.save_data_store
      expect(File.exists?(data_store.default_file)).to be_truthy
    end

    it "#wipe_data_store wipes the data store file" do
      add_random_data_point(data_store, provider)
      data_store.save_data_store
      data_store.wipe_data_store
      expect(File.exists?(data_store.default_file)).to be_falsey
    end

    it "#wipe_data_store resets the data store's @data attribute" do
      add_random_data_point(data_store, provider)
      data_store.save_data_store
      data_store.wipe_data_store
      expect(data_store.data).to eq(DEFAULT_DATA_STORE_HASH)
    end

    # This should guarantee that the data being written to .csv is correct.
    it "data stays the same when backed up and loaded using default files" do
      repetitions = Random.rand(0..50)
      repetitions.times { add_random_data_point(data_store, provider) }
      old_data = data_store.data
      data_store.save_data_store
      new_data_store = klass.new(false)
      new_data_store.load_data_store(data_store.default_file)
      new_data = new_data_store.data
      # Convert them to .csv-style arrays for easier comparison, which are
      # sorted by, therefore properly comparable.
      old_data = Status::DataStore.send(:data_to_rows, old_data)
      new_data = Status::DataStore.send(:data_to_rows, new_data)
      expect(old_data).to eq(new_data)
    end

    it "data stays the same when backed up and loaded with custom files" do
      repetitions = Random.rand(0..50)
      repetitions.times { add_random_data_point(data_store, provider) }
      old_data = data_store.data
      data_store.save_data_store("rspec_backup.csv")
      new_data_store = klass.new(false)
      new_data_store.load_data_store("rspec_backup.csv")
      new_data = new_data_store.data
      # Convert them to .csv-style arrays for easier comparison, which are
      # sorted by, therefore properly comparable.
      old_data = Status::DataStore.send(:data_to_rows, old_data)
      new_data = Status::DataStore.send(:data_to_rows, new_data)
      expect(old_data).to eq(new_data)
    end

    it "restore does not add duplicates (ex. merging same file's data twice)" do
      add_random_data_point(data_store, provider)
      old_data = data_store.data
      data_store.save_data_store("rspec_backup.csv")
      new_data_store = klass.new(false)
      new_data_store.load_data_store("rspec_backup.csv")
      new_data_store.load_data_store("rspec_backup.csv")
      new_data = new_data_store.data
      # Convert them to .csv-style arrays for easier comparison, which are
      # sorted by, therefore properly comparable.
      old_data = Status::DataStore.send(:data_to_rows, old_data)
      new_data = Status::DataStore.send(:data_to_rows, new_data)
      expect(old_data).to eq(new_data)
    end

  end

end
