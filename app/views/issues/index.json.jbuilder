json.array!(@issues) do |issue|
  json.extract! issue, 
  json.url issue_url(issue, format: :json)
end
