class UploadController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:upload_file]
  # Turn off because of testing via postman
  #before_action :uploader_params

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
    #uploader_params.respond_to?(:read) ? importer_params.read : importer_params
    # Postman file send with header 'multipart/form-data' workaround
    params.keys.first.to_s || ''
  end

  # TODO: import the uploaded file
  def import_file
    import = UserImportService.new( File.open(@filename){ |file| file.read } ) unless @filename.blank?
    FileUtils.rm(@filename, force: true)
    #render_json_status_message(import.meta[:status], import.meta[:message].join(' '))
  end
end
