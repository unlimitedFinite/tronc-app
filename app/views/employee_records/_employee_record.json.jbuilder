json.extract! employee_record, :id, :week_end, :tips, :employee_id, :created_at, :updated_at
json.url employee_record_url(employee_record, format: :json)
