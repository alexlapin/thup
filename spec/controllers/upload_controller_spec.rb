require 'rails_helper'

RSpec.describe UploadController, type: :controller do
  describe 'upload_file' do
    xit 'succeed' do
      post 'upload_file', params: {
          content: "id,first_name,last_name,employee_number\n20,John,Smith,100\n"
      }
      expect(response.status).to eq(200)
    end

    it 'returns unprocessable_entity with empty file body' do
      post 'upload_file', params: {}
      expect(response.status).to eq(422)
    end

    it 'failed' do
      expect { post 'whatever', params: {} }.to raise_exception ActionController::UrlGenerationError
    end
  end

  describe 'actions' do
    it 'can not allow to run methods except post' do
      expect { get '/' }.to raise_exception ActionController::UrlGenerationError
      expect { put '/', params: { id: '123456789'} }.to raise_exception ActionController::UrlGenerationError
    end
  end
end
