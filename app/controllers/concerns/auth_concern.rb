# frozen_string_literal: true

module AuthConcern
  extend ActiveSupport::Concern
  def authorized?
    current_user&.present?
  end

  def current_user
    return unless session[:user_id]

    User.find_by(id: session[:user_id])
  end

  def sign_out
    session.delete(:user_id)
    session.clear

    redirect_to root_path, notice: t('.success')
  end

  def sign_in(user_id)
    session['user_id'] = user_id
  end
end
