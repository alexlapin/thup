require 'rails_helper'

RSpec.describe Api::ImportController, type: :controller do
  describe 'import_csv' do
    # xitted due to postman
    xit 'succeed' do
      post 'import_csv', params: {
          file_stream: "id,first_name,last_name,employee_number\n1,John,Smith,100\n"
      }
      expect(response.status).to eq(200)
    end

    it 'returns unprocessable_entity with empty file body' do
      post 'import_csv', params: {}
      expect(response.status).to eq(422)
    end

    it 'failed' do
      expect { post 'whatever' }.to raise_exception ActionController::UrlGenerationError
    end
  end

  describe 'actions' do
    it 'can not allow to run methods except post' do
      expect { get '/' }.to raise_exception ActionController::UrlGenerationError
      expect { put '/', params: { id: '123456789'} }.to raise_exception ActionController::UrlGenerationError
    end
  end
end
