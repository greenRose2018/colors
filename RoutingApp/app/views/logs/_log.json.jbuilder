json.extract! log, :id, :title, :body, :created_at, :updated_at
json.url log_url(log, format: :json)
