class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def show; end

  def new
    client = Octokit::Client.new(access_token: current_user.token)
    @repositories = client.repositories(current_user.nickname)
                          .filter { |repository| repository[:language].downcase == 'ruby' }
  end

  def create; end
end
