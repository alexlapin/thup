require './lib/importers/user_importer'

class UserImportService
  attr_reader :errors, :meta

  def initialize(content)
    @errors = content.blank? || content.size.zero? ? ['File should be provided'] : []
    process_csv(content) if @errors.blank?
    @meta ||= { status: :unprocessable_entity, message: @errors }
  end

  private

  def process_csv(content)
    import = ImportUserCSV.new(content: content)
    if !import.valid_header?
      @errors << import.report.message
    else
      import.run!
    end
  rescue
    @errors << 'File could NOT be imported'
  ensure
    @meta = { status: @errors.blank? ? :ok : :unprocessable_entity,
              message: @errors.blank? ? [import.report.message] : @errors
    }
  end
end