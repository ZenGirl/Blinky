module Blinky
  class User
    include GroupMethods
    # Full list of fields for this model
    FIELDS_FULL    = [
        :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified,
        :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature,
        :organization_id, :tags, :suspended, :role
    ]
    # List of summary fields
    # TODO: Move up and ensure FIELDS_FULL includes it to avoid duplication
    FIELDS_SUMMARY = [
        :_id, :name, :alias, :active, :verified, :email, :phone, :signature, :tags, :suspended, :role
    ]
    # Hash of connections to other models
    FIELDS_DEEP    = {
        organization_id: Blinky::Organization
    }

    attr_accessor :rows

    # This loads the JSON into instances from the text
    # TODO: This should be simplified to be a common class method
    def self.load(ctx)
      @rows = self.load_group(ctx.users, FIELDS_FULL)
    end
  end
end
