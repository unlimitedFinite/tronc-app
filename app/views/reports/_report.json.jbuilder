json.extract! report, :id, :gross_tips, :tax_due, :net_tips, :created_at, :updated_at
json.url report_url(report, format: :json)
