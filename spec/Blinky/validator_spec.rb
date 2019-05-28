require_relative '../spec_helper'

describe Blinky::Validator do
  describe 'Methods' do
    it 'responds to call' do
      expect(Blinky::Validator.respond_to?(:call)).to eq true
    end
    it 'returns correct data home' do
      expect(subject.send(:get_data_home)).to eq('./spec/support')
    end
    describe '#ensure_good_environment' do
      it 'should fail if data_home not found' do
        subject.context.data_home = nil
        expect {subject.send(:ensure_good_environment)}.to raise_error(Interactor::Failure)
      end
      it 'should succeed if data_home found' do
        subject.send(:get_data_home)
        expect {subject.send(:ensure_good_environment)}.not_to raise_error(Interactor::Failure)
      end
    end
    describe '#ensure_data_home_exists' do
      it 'should fail if data_home not a directory' do
        subject.context.data_home = ''
        expect {subject.send(:ensure_data_home_exists)}.to raise_error(Interactor::Failure)
      end
      it 'should succeed if data_home is a directory' do
        subject.send(:get_data_home)
        expect {subject.send(:ensure_data_home_exists)}.not_to raise_error(Interactor::Failure)
      end
    end
    describe '#ensure_files_exist' do
      before(:all) do
        module Blinky
          TICKETS       = 'tickets_valid.json'
          USERS         = 'users_valid.json'
          ORGANIZATIONS = 'organizations_valid.json'
        end
      end
      it 'should fail if files not found' do
        subject.context.data_home = ''
        expect {subject.send(:ensure_files_exist)}.to raise_error(Interactor::Failure)
      end
      it 'should succeed if files are found' do
        subject.send(:get_data_home)
        expect {subject.send(:ensure_files_exist)}.not_to raise_error(Interactor::Failure)
      end
    end
    describe '#ensure_valid_json' do
      describe 'failed' do
        before(:all) do
          module Blinky
            TICKETS       = 'tickets_invalid.json'
            USERS         = 'users_invalid.json'
            ORGANIZATIONS = 'organizations_invalid.json'
          end
        end
        it 'Tickets should fail if not valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::TICKETS)}.to raise_error(Interactor::Failure)
        end
        it 'Users should fail if not valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::USERS)}.to raise_error(Interactor::Failure)
        end
        it 'Organizations should fail if not valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::ORGANIZATIONS)}.to raise_error(Interactor::Failure)
        end
      end
      describe 'succeeded' do
        before(:all) do
          module Blinky
            TICKETS       = 'tickets_valid.json'
            USERS         = 'users_valid.json'
            ORGANIZATIONS = 'organizations_valid.json'
          end
        end
        it 'Tickets should succeed if valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::TICKETS)}.not_to raise_error(Interactor::Failure)
        end
        it 'Users should succeed if valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::USERS)}.not_to raise_error(Interactor::Failure)
        end
        it 'Organizations should succeed if valid json' do
          subject.send(:get_data_home)
          expect {subject.send(:ensure_valid_json, Blinky::ORGANIZATIONS)}.not_to raise_error(Interactor::Failure)
        end
      end
    end
    describe '#fail_with_msg' do
      it 'fails with correct message' do
        expect{subject.send(:fail_with_msg, 'Hello Blinky')}.to raise_error { |obj|
          expect(obj).to be_a(Interactor::Failure)
          expect(subject.context.error).to eq('Hello Blinky')
        }
      end
    end
  end
end
