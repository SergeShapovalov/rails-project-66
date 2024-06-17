# frozen_string_literal: true
module Web
  class AuthController < Web::ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      user_info = auth_hash['info']

      user = User.find_or_initialize_by(email: user_info[:email].downcase)
      user.name = user_info[:name]

      if user.save
        sign_in(user.id)
        flash[:success] = t('.success')
      else
        flash[:failure] = t('.failed')
      end

      redirect_to root_path
    end
  end
end
