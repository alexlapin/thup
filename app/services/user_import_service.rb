require './lib/importers/user_importer'

class UserImportService
  UNKNOWN_ERROR = 'Unknown error'

  attr_reader :errors, :meta

  def initialize(content)
    @errors = content ? [] : ['File should be provided']
    process_csv(content)
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