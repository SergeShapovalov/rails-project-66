module Web
  class ApplicationController < ApplicationController
    include Pundit::Authorization
    include AuthConcern

    rescue_from Pundit::NotAuthorizedError, with: :authorize_error

    def authorize_user
      return if authorized?

      redirect_to root_path, alert: t('.not_authorized')
    end

    def authorize_error
      redirect_to root_path, alert: t('.authorize_error')
    end
  end
end
