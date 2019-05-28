module Blinky
  class Ticket
    include GroupMethods
    # Full list of fields for this model
    FIELDS_FULL = [
        :_id, :url, :external_id, :created_at, :type, :subject, :description,
        :priority, :status, :submitter_id, :assignee_id, :organization_id,
        :tags, :has_incidents, :due_at, :via
    ]
    # List of summary fields
    # TODO: Move up and ensure FIELDS_FULL includes it to avoid duplication
    FIELDS_SUMMARY = [
        :_id, :type, :subject, :description, :priority, :status, :tags, :has_incidents
    ]
    # Hash of connections to other models
    FIELDS_DEEP = {
        organization_id: Blinky::Organization,
        submitter_id:    Blinky::User
    }

    attr_accessor :rows

    # This loads the JSON into instances from the text
    # TODO: This should be simplified to be a common class method
    def self.load(ctx)
      @rows = self.load_group(ctx.tickets, FIELDS_FULL)
    end
  end
end
