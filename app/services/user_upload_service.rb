class UserUploadService
  attr_reader :errors, :meta, :filename

  def initialize(io_content)
    @errors = io_content.blank? || io_content.size.zero? ? ['File should be provided'] : []
    upload_file(io_content) if @errors.blank?
    @meta ||= { status: :unprocessable_entity, message: @errors }
  end

  private

  def upload_file(io_content)
    @filename = Rails.root.join('public', 'uploads', (Time.now.to_f.to_s+'.csv'))
    # TODO: read and write by chunks
    File.open(@filename, 'wb') do |file|
      file.write(io_content.respond_to?(:read) ? io_content.read : io_content)
    end
  rescue
    @errors << 'File could NOT be uploaded'
    FileUtils.rm(@filename, force: true)
  ensure
    @meta = { status: @errors.blank? ? :ok : :unprocessable_entity,
              message: @errors.blank? ? ['File was uploaded successfully'] : @errors
    }
  end
end