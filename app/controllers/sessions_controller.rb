class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      cookie_options = { value: user.id, httponly: true }
      cookie_options[:secure] = true if Rails.env.production?
      cookie_options[:same_site] = "None" if Rails.env.production?
      cookies.signed[:user_id] = cookie_options

      render json: { email: user.email, user_id: user.id }, status: :created
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    cookie_options = {}
    cookie_options[:secure] = true if Rails.env.production?
    cookie_options[:same_site] = "None" if Rails.env.production?
    cookies.delete(:user_id, cookie_options)

    render json: { message: "Logged out successfully" }
  end
end
