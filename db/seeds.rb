User.destroy_all
new_user = {
  email: 'tyler@example.com',
  password: 'password',
  password_confirmation: 'password'
}
user = User.create(new_user)
