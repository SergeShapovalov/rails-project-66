# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      email = auth_hash[:info][:email].downcase

      user = User.find_or_initialize_by(email:)
      user.nickname = auth_hash[:info][:nickname]
      user.token = auth_hash[:credentials][:token]
      user.provider = auth_hash[:provider]
      user.uid = auth_hash[:uid]

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
