module Blinky
  class Organization
    include GroupMethods
    # Full list of fields for this model
    FIELDS_FULL    = [
        :_id, :url, :external_id, :name, :domain_names, :created_at,
        :details, :shared_tickets, :tags
    ]
    # List of summary fields
    # TODO: Move up and ensure FIELDS_FULL includes it to avoid duplication
    FIELDS_SUMMARY = [:_id, :name, :domain_names, :details, :tags]
    # Hash of connections to other models
    FIELDS_DEEP    = {}

    attr_accessor :rows

    # This loads the JSON into instances from the text
    # TODO: This should be simplified to be a common class method
    def self.load(ctx)
      @rows = self.load_group(ctx.organizations, FIELDS_FULL)
    end
  end
end
