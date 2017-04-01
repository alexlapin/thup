Rails.application.routes.draw do
  post 'import/import_csv', to: 'import#import_csv'
  post 'upload/upload_file', to: 'upload#upload_file'
  resources :users, only: [:index]
end
