require_relative '../spec_helper'

describe Blinky::Loader do
  describe 'Methods' do
    before(:all) do
      module Blinky
        TICKETS       = 'tickets_valid.json'
        USERS         = 'users_valid.json'
        ORGANIZATIONS = 'organizations_valid.json'
      end
    end
    it 'responds to call' do
      expect(subject.respond_to?(:call)).to eq true
    end
    it 'responds to canonical_name' do
      expect {subject.send(:canonical_name, 'hello.json')}.not_to raise_error
      expect(subject.send(:canonical_name, 'hello.json')) == 'Hello'
    end
    it 'responds to field_names' do
      expect {subject.send(:field_names, Blinky::User.attributes(:full))}.not_to raise_error
        expect(subject.send(:field_names, Blinky::User.attributes(:full))).to eq '_id, url, external_id, name, alias, created_at, active, verified, shared, locale, timezone, last_login_at, email, phone, signature, organization_id, tags, suspended, role'
    end
  end
end
