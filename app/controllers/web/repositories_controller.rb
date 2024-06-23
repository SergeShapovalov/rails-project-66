class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def show; end

  def new
    @repositories = repositories
  end

  def create
    @repository = current_user.repositories.find_or_initialize_by(repository_params)

    if @repository.save!
      redirect_to repositories_path, notice: t('create_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end

  def repositories
    client = Octokit::Client.new(access_token: current_user.token)
    client.repositories(current_user.nickname)
          .filter { |repository| repository[:language].downcase == 'ruby' }
  end
end
