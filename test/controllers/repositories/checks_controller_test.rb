require "test_helper"

class Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get repositories_checks_show_url
    assert_response :success
  end

  test "should get create" do
    get repositories_checks_create_url
    assert_response :success
  end
end
