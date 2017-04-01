require 'rails_helper'
require './app/services/user_import_service'

RSpec.describe UserImportService do
  describe 'initialize' do
    context 'with valid parameters' do
      let! (:uis) { UserImportService.new("id,first_name,last_name,employee_number\n1,John,Smith,100\n") }

      it 'succeed with file import' do
        expect (uis.errors).should be_empty
      end
      it 'proceed successfully message' do
        expect (uis.meta[:message]).should match_array ['Import completed: 1 created']
      end
    end

    context 'with required parameters missing' do
      let! (:uis_failed_record_creation) { UserImportService.new("id,first_name,last_name,employee_number\n2,John,Smith\n") }

      it 'succeed with file import' do
        expect (uis_failed_record_creation.errors).should be_empty
      end
      it 'return a failed record creation' do
        expect (uis_failed_record_creation.meta[:message]).should match_array ['Import completed: 1 failed to create']
      end
    end

    context 'with blank parameters' do
      let! (:file_provided) { 'File should be provided' }
      let! (:uis_nil) { UserImportService.new(nil) }
      let! (:uis_empty) { UserImportService.new('') }
      let! (:uis_empty_io) { UserImportService.new(StringIO.new) }

      it 'return an error of missing file if nil is provided' do
        expect (uis_nil.errors).should match_array([file_provided])
      end
      it 'return an error of missing file if empty string is provided' do
        expect (uis_empty.errors).should match_array([file_provided])
      end
      it 'return an error of missing file if empty StringIO is provided' do
        expect (uis_empty_io.errors).should match_array([file_provided])
      end
    end

    context 'with invalid parameters' do
      let! (:uis_corrupted) { UserImportService.new("id,first_name,last_name,\n2,John,Smith,200\n") }

      it 'return a file validation error' do
        expect (uis_corrupted.errors).should_not be_empty
      end
    end
  end
end
