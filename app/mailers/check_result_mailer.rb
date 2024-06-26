# frozen_string_literal: true

class CheckResultMailer < ApplicationMailer
  before_action :set_vars

  def failed_check_email
    mail(
      to: @user.email,
      subject: t('.message')
    )
  end

  def error_check_email
    mail(
      to: @user.email,
      subject: t('.message')
    )
  end

  def passed_check_email
    mail(
      to: @user.email,
      subject: t('.message')
    )
  end

  private

  def set_vars
    @repository = Repository.find(params[:repository_id])
    @user = User.find(params[:user_id])
    @check = @repository.checks.order(created_at: :desc).first
  end
end
