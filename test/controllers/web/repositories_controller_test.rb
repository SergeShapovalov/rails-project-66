# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get index page' do
    sign_in @user

    get repositories_url
    assert :success
  end

  test 'should NOT get index page' do
    get repositories_url
    assert_redirected_to root_path
  end

  test 'should get new' do
    sign_in @user

    get new_repository_url
    assert_response :success
  end

  test 'should show repository' do
    sign_in @user

    get repository_url(repositories(:one))
    assert_response :success
  end

  test 'should create repository' do
    sign_in @user

    repository_id = 999

    post repositories_url, params: { repository: { github_id: repository_id } }

    assert ::Repository.find_by(github_id: repository_id)
  end
end
