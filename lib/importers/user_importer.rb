class ImportUserCSV
  # id, first_name, employee_number are required
  include CSVImporter
  model User
  column :employee_number, required: true
  column :user_id, as: 'id', required: true
  column :first_name, to: ->(first_name) { first_name.downcase }, required: true
  column :last_name, to: ->(last_name) { last_name.downcase }

  identifier :employee_number
  when_invalid :skip
end