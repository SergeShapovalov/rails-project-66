# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authorize_user

  def index
    @repositories = current_user.repositories.includes(:checks)
  end

  def show
    @repository = Repository.find(params[:id])
    authorize @repository
  end

  def new
    repository = current_user.repositories.build
    authorize repository

    @repositories = ApplicationContainer[:octokit_client].repositories(current_user)
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)
    authorize @repository

    if @repository.save!
      repository_info = ApplicationContainer[:octokit_client].repository(current_user, @repository)

      @repository.update!(
        language: repository_info[:language]&.downcase,
        name: repository_info[:name],
        full_name: repository_info[:full_name],
        clone_url: repository_info[:clone_url],
        ssh_url: repository_info[:ssh_url]
      )

      CreateHookJob.perform_now(current_user, @repository)

      redirect_to repositories_path, notice: t('repository.create.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end
end
