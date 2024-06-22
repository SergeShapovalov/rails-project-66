class Web::RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show; end

  def new; end

  def create; end
end
