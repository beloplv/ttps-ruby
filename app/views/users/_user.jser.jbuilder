json.extract! user, :id, :email, :role
json.url user_url(user, format: :json)