json.status 200
json.body do
  json.data do
    json.type 'users'
    json.id @user.id
    json.attributes do
      json.email @user.email
      json.api_key @user.api_key
    end
  end
end
