require 'terminal-table'

module Status
	class History
    # @parreirat NOTE - Could branch this off into subclasses responsible
    #   for implementing different types of output schemes...

    INVALID_DATA_STORE_MSG = ":data_store is not a Status::DataStore object."

    attr_reader :data

    def initialize(data_store)
      raise ArgumentError, INVALID_DATA_STORE_MSG unless data_store.is_a?(Status::DataStore)
      set_data!(data_store.data)
    end

    def set_data!(data)
      @data = data
    end

    def print(format = :standard_table)
      method_name = "print_#{format}"
      # 2nd argument set to true allows scanning for private methods.
      responds = respond_to?(method_name.to_sym, true)
      raise NotImplementedError, no_method_message(method_name) unless responds
      send(method_name)
    end

    private

      def print_standard_table
        rows = []
        data.each do |provider, data_points|
          data_points.each do |data_point|
            rows << [
              provider.capitalize,
              data_point[:status].capitalize,
              data_point[:time]
            ]
          end
        end
        # Sort data by most recent on top, facilitates human readability.
        # @parreirat NOTE - Not sure if we should be using UTC, the
        #   document does not specify time zone but the display has no
        #   time zone offset printed.
        rows.sort_by!{ |provider, status, time| time }.reverse!
        table = Terminal::Table.new({
          headings: ["Service", "Status", "Time"],
          rows:     rows,
          title:    "Webpage statuses data",
          style: {
            all_separators: true,
            padding_right:  2,
            padding_left:   2,
            alignment:      :center
          }
        })
        puts table
      end

      def no_method_message(method_name)
        "'#{method_name}' is not implemented in Status::History object."
      end

	end
end