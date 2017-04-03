Rails.application.routes.draw do
  namespace :api do
    post 'import/import_csv', to: 'import#import_csv'
  end
  post 'upload/upload_file', to: 'upload#upload_file'

  resources :users, only: [:index]

  # SPA home will be defined later
  get '*path', to: 'home#index', constrains: -> (request) do
    !request.xhr? && request.format.html?
  end

  root :to => 'home#index'
end
