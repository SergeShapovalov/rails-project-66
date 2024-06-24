# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def show
    @check = Repository::Check.find(params[:id])
  end

  def create
    repository = Repository.find(params[:repository_id])
    check = repository.checks.create!

    CheckRepositoryJob.perform_now(current_user, check)

    flash[:notice] = t('.success')
    redirect_to repository
  end
end
