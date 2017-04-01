require 'rails_helper'
require './app/services/user_upload_service'

RSpec.describe UserUploadService do
  describe 'initialize' do
    let! (:csv_content) { "id,first_name,last_name,employee_number\n1,John,Smith,100\n" }

    context 'with valid parameters' do
      let! (:uus) { UserUploadService.new(csv_content) }
      let! (:uus_io) { UserUploadService.new( StringIO.new(csv_content)) }
      let! (:uus_file) {
        File.open('tempfile.csv', 'wb') do |file|
          file.write(csv_content)
        end
        upload = UserUploadService.new(File.open('tempfile.csv', 'rb').read)
        FileUtils.rm('tempfile.csv', force: true)
        upload
      }

      it 'succeed with file upload' do
        expect (uus.errors).should be_empty
      end
      it 'proceed successfully message' do
        expect (uus.meta[:message]).should match_array ['File was uploaded successfully']
      end
    end

    context 'with blank parameters' do
      let! (:file_provided) { 'File should be provided' }
      let! (:uus_nil) { UserUploadService.new(nil) }
      let! (:uus_empty) { UserUploadService.new('') }
      let! (:uus_empty_io) { UserUploadService.new(StringIO.new) }

      it 'return an error of missing file if nil is provided' do
        expect (uus_nil.errors).should match_array([file_provided])
      end
      it 'return an error of missing file if empty string is provided' do
        expect (uus_empty.errors).should match_array([file_provided])
      end
      it 'return an error of missing file if empty StringIO is provided' do
        expect (uus_empty_io.errors).should match_array([file_provided])
      end
    end
  end
end
