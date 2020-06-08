if @user.status == 201
  json.status @user.status
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
else
  json.status @user.status
  json.body do
    json.message @user.four_o_four
  end
end
