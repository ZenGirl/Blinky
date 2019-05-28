require_relative '../spec_helper'

RSpec.describe Blinky::User do

  describe 'Directories' do
    it 'should use the spec/support directory' do
      expect(ENV['BLINKY_DATA_HOME']).to eq './spec/support'
    end
  end

  describe 'Fields' do

    it 'should have full fields' do
      expect(Blinky::User::FIELDS_FULL).to eq([
                                                  :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified,
                                                  :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature,
                                                  :organization_id, :tags, :suspended, :role
                                              ])
    end

    it 'should have summary fields' do
      expect(Blinky::User::FIELDS_SUMMARY).to eq([:_id, :name, :alias, :active, :verified, :email, :phone, :signature, :tags, :suspended, :role])
    end

    it 'should have deep fields' do
      expect(Blinky::User::FIELDS_DEEP).to eq({organization_id: Blinky::Organization})
    end
  end

  describe 'Group Methods' do
    it 'supports load' do
      expect(Blinky::User.respond_to?(:load)).to eq true
    end
    it 'supports load_group' do
      expect(Blinky::User.respond_to?(:load_group)).to eq true
    end
    it 'supports search' do
      expect(Blinky::User.respond_to?(:search)).to eq true
    end
    it 'supports table_row' do
      expect(Blinky::User.respond_to?(:table_row)).to eq true
    end
    it 'supports get_variable' do
      expect(Blinky::User.respond_to?(:get_variable)).to eq true
    end
    it 'supports attributes' do
      expect(Blinky::User.respond_to?(:attributes)).to eq true
    end
  end

end
