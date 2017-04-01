require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it 'returns a user' do
    get :index
    expect(response.status).to eq(200)
  end

  it 'can not allow to run queries except index' do
    expect { get :show, params: { id: '123456789'} }.to raise_exception ActionController::UrlGenerationError
    expect { get :edit, params: { id: '123456789'} }.to raise_exception ActionController::UrlGenerationError
    expect { get :new }.to raise_exception ActionController::UrlGenerationError
    expect { post :create }.to raise_exception ActionController::UrlGenerationError
    expect { put :update, params: { id: '123456789' } }.to raise_exception ActionController::UrlGenerationError
  end
end
