require_relative '../spec_helper'

RSpec.describe Blinky::Organization do

  describe 'Directories' do
    it 'should use the spec/support directory' do
      expect(ENV['BLINKY_DATA_HOME']).to eq './spec/support'
    end
  end

  describe 'Fields' do

    it 'should have full fields' do
      expect(Blinky::Organization::FIELDS_FULL).to eq([
                                                          :_id, :url, :external_id, :name, :domain_names, :created_at,
                                                          :details, :shared_tickets, :tags
                                                      ])
    end

    it 'should have summary fields' do
      expect(Blinky::Organization::FIELDS_SUMMARY).to eq([:_id, :name, :domain_names, :details, :tags])
    end

    it 'should have deep fields' do
      expect(Blinky::Organization::FIELDS_DEEP).to eq({})
    end
  end

  describe 'Group Methods' do
    it 'supports load' do
      expect(Blinky::Organization.respond_to?(:load)).to eq true
    end
    it 'supports load_group' do
      expect(Blinky::Organization.respond_to?(:load_group)).to eq true
    end
    it 'supports search' do
      expect(Blinky::Organization.respond_to?(:search)).to eq true
    end
    it 'supports table_row' do
      expect(Blinky::Organization.respond_to?(:table_row)).to eq true
    end
    it 'supports get_variable' do
      expect(Blinky::Organization.respond_to?(:get_variable)).to eq true
    end
    it 'supports attributes' do
      expect(Blinky::Organization.respond_to?(:attributes)).to eq true
    end
  end
end
