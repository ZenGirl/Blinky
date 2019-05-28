module Blinky
  module GroupMethods
    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods

      # Takes a hash of JSON data, creates relevant models, loads the attributes and returns the result
      def load_group(group, fields)
        rows = []
        group.each do |row|
          obj = new
          fields.each {|attr| obj.instance_variable_set("@#{attr}", row[attr].to_s)}
          rows << obj
        end
        rows
      end

      # Simple search of the models hash case insensitive
      def search(field, value)
        @rows.select {|row| get_variable(row, field).downcase == value.downcase}
      end

      # Builds an output row for display in a nice table
      def table_row(obj, out_mode, depth)
        row = []
        variables = out_mode == :full ? obj.class::FIELDS_FULL : obj.class::FIELDS_SUMMARY
        variables.each do |var|
          val = obj.instance_variable_get("@#{var}")
          val = val[0..32] if out_mode == :summary # Shorten data for summary - BRUTE FORCE - should be neater
          row << val
        end
        if depth == :deep
          # Deep! So check the connection, do a search and attach the new column
          obj.class::FIELDS_DEEP.each do |key, klass|
            deep_id = obj.instance_variable_get("@#{key}")
            tab = "#{key}=>#{klass}\n"
            klass.search('_id', deep_id).each do |deep_obj|
              deep_obj.class::FIELDS_SUMMARY.each do |deep_var|
                tab += "#{deep_var}: #{deep_obj.instance_variable_get("@#{deep_var}")}\n"
              end
            end
            row << tab
          end
        end
        row
      end

      # Shorthand for getting a variables value
      def get_variable(row, field)
        val = row.instance_variable_get("@#{field}")
        val.nil? ? '' : val
      end

      # Shorthand for getting the list of attributes to display
      def attributes(out_mode)
        (out_mode == :full ? self::FIELDS_FULL : self::FIELDS_SUMMARY).map(&:to_s)
      end

    end
  end
end
