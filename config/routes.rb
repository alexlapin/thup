Rails.application.routes.draw do
  post 'imports/import_csv', to: 'imports#import_csv'
  post 'upload/upload_file', to: 'upload#upload_file'
  resources :imports, only: [:index, :new] do

  end
end
