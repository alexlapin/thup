class UserUploadService
  attr_reader :errors, :meta, :filename

  def initialize(io_content)
    @errors = io_content ? [] : ['File should be provided']
    upload_file(io_content)
  end

  private

  def upload_file(io_content)
    @filename = Rails.root.join('public', 'uploads', (Time.now.to_f.to_s+'.csv'))
    # TODO: read and write by chunks
    File.open(@filename, 'wb') do |file|
      file.write(io_content.read)
    end
  rescue
    @errors << 'File could NOT be uploaded'
  ensure
    @meta = { status: @errors.blank? ? :ok : :unprocessable_entity,
              message: @errors.blank? ? ['File was uploaded successfully'] : @errors
    }
  end
end