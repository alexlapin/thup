require './app/services/user_import_service'

class ImportController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:import_csv]
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

  def get_csv_content
    # TODO: use whitelist params
    return params.keys.first.to_s || ''
  end
end
