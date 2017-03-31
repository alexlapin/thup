require 'stringio'

class UploadController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:upload_file]

  def upload_file
    file = StringIO.new(get_file_content.respond_to?(:read) ? get_file_content.read : get_file_content)
    upload = UserUploadService.new(file)
    @filename = upload.filename if upload.meta[:status] == :ok
    render_json_status_message(upload.meta[:status], upload.meta[:message].join(' '))
  end

  private

  def uploader_params
    params.require(:file)
  end

  def get_file_content
    # TODO: use whitelist params
    return params.keys.first.to_s || ''
  end

  # Import the uploaded file
  def import_file
    import = UserImportService.new( File.open(@filename){ |file| file.read } ) unless @filename.blank?
    #render_json_status_message(import.meta[:status], import.meta[:message].join(' '))
  end
end
