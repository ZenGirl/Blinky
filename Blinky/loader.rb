module Blinky
  class Loader
    include Interactor

    # Loading interactor
    # The context will have the data loaded into sub-values within the context
    def call
      # Reserve names
      # TODO: This needs to be moved into the model
      context.users_name         = canonical_name(Blinky::USERS)
      context.organizations_name = canonical_name(Blinky::ORGANIZATIONS)
      context.tickets_name       = canonical_name(Blinky::TICKETS)
      # Show statistics
      display_table
      # Load the data
      # TODO: Loop.
      Blinky::User.load(context)
      Blinky::Organization.load(context)
      Blinky::Ticket.load(context)
    end

    private

    # Displays a nice table with details
    def display_table
      # TODO: This should loop over the models
      # The Blinky::XXX.attributes finds the models field names.
      rows = [
          [context.users_name, context.users.size, field_names(Blinky::User.attributes(:full))],
          [context.organizations_name, context.organizations.size, field_names(Blinky::Organization.attributes(:full))],
          [context.tickets_name, context.tickets.size, field_names(Blinky::Ticket.attributes(:full))]
      ]
      puts Terminal::Table.new headings: %w(Group Count Fields), rows: rows
    end

    # Converts a name like `tickets.json` into Tickets
    def canonical_name(file_name)
      file_name.gsub(/\.json$/, '').capitalize
    end

    # Reads the attributes for a model into a friendly format
    def field_names(attributes)
      attributes.join(', ')
    end

  end
end
