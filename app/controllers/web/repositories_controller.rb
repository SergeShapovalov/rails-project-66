class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repositories = repositories
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)

    if @repository.save!
      repository_info = ApplicationContainer[:octokit_client].repository(current_user, @repository)

      @repository.update!(
        language: repository_info[:language].downcase,
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

  def repositories
    ApplicationContainer[:octokit_client].repositories(current_user)
  end
end
