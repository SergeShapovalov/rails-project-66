require "test_helper"

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
end
