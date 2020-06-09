class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: email)
    @user.authenticate(pass) ? two_hundred(@user) : four_o_one
  end

  private

  def two_hundred(user)
    session[:user_id] = user.id
    render '/sessions/success.json'
  end

  def four_o_one
    render '/sessions/failure.json'
  end

  def email
    params[:email]
  end

  def pass
    params[:password]
  end
end
