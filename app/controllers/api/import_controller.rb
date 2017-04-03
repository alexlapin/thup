require './app/services/user_import_service'

module Api
  class ImportController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:import_csv]
    # Turn off because of testing via postman
    #before_action :importer_params

    def import_csv
      content = get_csv_content
      import = UserImportService.new(content)
      render_json_status_message(import.meta[:status], import.meta[:message].join(' '))
    end

    private

    def importer_params
      params.require(:file)
    end

    # TODO: use whitelist params
    def get_csv_content
      #importer_params.respond_to?(:read) ? importer_params.read : importer_params
      # Postman file send with header 'multipart/form-data' workaround
      params.keys.first.to_s || ''
    end
  end
end
