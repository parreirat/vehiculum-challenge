require 'csv'
require 'time'

module Status

  # Responsible for holding our data, saving, restoring and merging it.
  class DataStore
    # @parreirat NOTE - Could branch this off into subclasses responsible
    #   for implementing different types of save/load schemes, ex.: JSON,
    #   serialization into binary or YAML...

    # @parreirat NOTE - Might not be the smartest things having separate
    #   formats for :data and the data we export into CSV, unnecessary
    #   processing... tradeoff of being easier to manipulate at run time and
    #   being easier to dump and load from files.

    INVALID_PROVIDER_MSG = ":provider is not a Symbol object."
    INVALID_STATUS_MSG   = ":status is not a Symbol object."
    INVALID_TIME_MSG     = ":provider is not a Time object."

    # Format example for data:
    # {
    #   cloudflare: [
    #     { status: :up,   time: 2018-06-25 00:57:11 +0100 }
    #   ],
    #   github: [
    #     { status: :up,   time: 2018-06-25 00:57:27 +0100 },
    #     { status: :down, time: 2018-06-25 00:57:09 +0100 }
    #   ],
    #   bitbucket: [
    #     { status: :down, time: 2018-06-25 00:57:26 +0100 }
    #   ]
    # }
    attr_accessor :data

    def wipe_data_store(file = default_file)
      File.delete(file) if File.exists?(file)
    end

    def initialize(load_default_file = true)
      initialize_data_store
      merge_data_store(default_file) if load_default_file
    end

    def add_data_point(provider, status, time)
      raise ArgumentError, INVALID_PROVIDER_MSG unless provider.is_a?(Symbol)
      raise ArgumentError, INVALID_STATUS_MSG unless status.is_a?(Symbol)
      raise ArgumentError, INVALID_TIME_MSG unless time.is_a?(Time)
      data_point = { status: status, time: time }
      @data[provider] << data_point
    end

    def save_data_store(file = default_file)
      csv_data = []
      @data.each do |provider, data_points|
        data_points.each do |data_point|
          csv_data << [
            provider.capitalize,
            data_point[:status].capitalize,
            data_point[:time].to_s
          ]
        end
      end
      # Sort data by most recent on top, facilitates human readability.
      csv_data.sort_by!{ |provider, status, time| time }.reverse!
      CSV.open(file, "wb") do |csv|
        csv << csv_headers
        csv_data.each do |csv_row|
          csv << csv_row
        end
      end
    end

    # Merging is trivial, use it along with load.
    def initialize_data_store
      @data = empty_data_store
    end

    # Loads data from 'file' into current data store, and saves it into the
    # default file, effectively "loading" the data, since "our data" is the
    # state of the default file loaded on initialization.
    def load_data_store(from_file)
      return false unless File.exists?(from_file)
      merge_data_store(from_file)
      save_data_store(default_file)
    end

    def merge_data_store(from_file)
      return false unless File.exists?(from_file)
      CSV.foreach(from_file).with_index do |row, index|
        next if index == 0 # Skip headers, assume static positioning.
        provider = row[0].downcase.to_sym
        status   = row[1].downcase.to_sym
        time     = Time.parse(row[2])
        add_data_point(provider, status, time)
      end
      @data
    end

    private

      def csv_headers
        ["Service", "Status", "Time"]
      end

      # Default file which we use as the data store. Saving and loading from
      # other files is considered "backups" and "restores".
      def default_file
        "default_data_store.csv"
      end

      # Returns hash of all providers with empty arrays as values:
      # {
      #   github: [],
      #   bitbucket: [],
      #   cloudflare: [],
      #   rubygems: []
      # }
      def empty_data_store
        hash = {}
        # Gets us the keys, ex.: [:github, :bitbucket, :cloudflare, :rubygems]
        page_keys = Status::Page.implemented_pages.map(&:to_s).map do |klass|
          klass.split("::")[2].downcase.to_sym
        end
        page_keys.each do |key|
          hash[key] = []
        end
        hash
      end

  end
end