require_relative '../spec_helper'

RSpec.describe Blinky::Ticket do

  describe 'Directories' do
    it 'should use the spec/support directory' do
      expect(ENV['BLINKY_DATA_HOME']).to eq './spec/support'
    end
  end

  describe 'Fields' do

    it 'should have full fields' do
      expect(Blinky::Ticket::FIELDS_FULL).to eq([
                                                    :_id, :url, :external_id, :created_at, :type, :subject, :description,
                                                    :priority, :status, :submitter_id, :assignee_id, :organization_id,
                                                    :tags, :has_incidents, :due_at, :via
                                                ])
    end

    it 'should have summary fields' do
      expect(Blinky::Ticket::FIELDS_SUMMARY).to eq([:_id, :type, :subject, :description, :priority, :status, :tags, :has_incidents])
    end

    it 'should have deep fields' do
      expect(Blinky::Ticket::FIELDS_DEEP).to eq({organization_id: Blinky::Organization, submitter_id: Blinky::User})
    end
  end

  describe 'Group Methods' do
    it 'supports load' do
      expect(Blinky::Ticket.respond_to?(:load)).to eq true
    end
    it 'supports load_group' do
      expect(Blinky::Ticket.respond_to?(:load_group)).to eq true
    end
    it 'supports search' do
      expect(Blinky::Ticket.respond_to?(:search)).to eq true
    end
    it 'supports table_row' do
      expect(Blinky::Ticket.respond_to?(:table_row)).to eq true
    end
    it 'supports get_variable' do
      expect(Blinky::Ticket.respond_to?(:get_variable)).to eq true
    end
    it 'supports attributes' do
      expect(Blinky::Ticket.respond_to?(:attributes)).to eq true
    end
  end
end
