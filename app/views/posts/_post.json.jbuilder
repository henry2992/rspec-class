json.extract! post, :id, :author, :text, :created_at, :updated_at
json.url post_url(post, format: :json)