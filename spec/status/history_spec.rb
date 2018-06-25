RSpec.describe Status::History do

  let(:data_store) { Status::DataStore.new(false) }

  # @parreirat TODO - Fixture file with a pre-seeded table, check expected
  # table against fixture?

  it "raises exception when initializing with an object which is not a Status::DataStore" do
    expect{ Status::History.new("string") }.to raise_error
  end

  it "initialize without error with a valid Status::DataStore" do
    expect{ Status::History.new(data_store) }.to_not raise_error
  end

  # Let's keep it simple and expect there to be some output with some entries.
  it "expect a simple table of 10 entries to print to stdout" do
    10.times do
      args = [
        [:cloudflare, :github, :bitbucket, :rubygems].sample,
        [:up, :down].sample,
        Time.now.round
      ]
      data_store.add_data_point(*args)
    end
    history = Status::History.new(data_store)
    expect { history.print }.to output.to_stdout
  end

end
