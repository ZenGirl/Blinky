module Blinky
  class Validator
    include Interactor

    def call
      get_data_home
      ensure_good_environment # Is it blank?
      ensure_data_home_exists # Does it exist?
      ensure_files_exist # Do the files exist?
      # All good - on to the loader
    end

    private

    # Simply extracts the name of the data directory
    def get_data_home
      context.data_home = ENV['BLINKY_DATA_HOME']
    end

    # Ensures that the data directory is set
    def ensure_good_environment
      puts 'Blinky: Validating environment'
      if context.data_home.nil?
        fail_with_msg 'The BLINKY_DATA_HOME environment variable is not set'
      end
    end

    # Ensures that the directory actually exists
    def ensure_data_home_exists
      unless File.directory?(context.data_home)
        fail_with_msg "The BLINKY_DATA_HOME directory (#{context.data_home}) could not be located"
      end
    end

    # Ensures that all files are present and load the input into the context
    # TODO: Move the file names into the models to ensure separation and simplify
    def ensure_files_exist
      puts 'Blinky: Validating files'
      context.tickets       = ensure_valid_json(Blinky::TICKETS)
      context.users         = ensure_valid_json(Blinky::USERS)
      context.organizations = ensure_valid_json(Blinky::ORGANIZATIONS)
      # TODO: Validate each file ensuring correct fields are present
    end

    # A simple test to ensure that the files are actually valid JSON
    def ensure_valid_json(file_name)
      # Exist?
      file_name = "#{context.data_home}/#{file_name}"
      puts "Blinky: Validating #{file_name}"
      unless File.exist?(file_name)
        fail_with_msg "The #{file_name} file could not be located in #{context.data_home}"
      end
      # Is JSON?
      json = nil
      begin
        # Too big?
        f       = File.open(file_name)
        f_count = f.count
        f.close
        if f_count > 10_000
          fail_with_msg "The #{file_name} has too many lines (#{f.count}) to be handled by Blinky"
        end
        # Nope. Load it
        json = MultiJson.load(IO.read(file_name), :symbolize_keys => true)
      rescue MultiJson::ParseError => exception
        fail_with_msg "The #{file_name} has an error: #{exception.cause} at #{exception.data}"
      end
      json
    end

    # Fail fast
    def fail_with_msg(msg)
      context.error = msg
      context.fail!
    end

  end
end
