require "bundler/setup"

require "status"
require "awesome_print"
require "pry"
require "pry-byebug"
require "vcr"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  # config.configure_rspec_metadata!
end

# @parreirat NOTE - Our custom configurations.
RSpec::Expectations.configuration.on_potential_false_positives = :nothing