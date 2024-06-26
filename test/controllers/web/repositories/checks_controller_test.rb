# frozen_string_literal: true

require 'test_helper'

class Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
    @check = repository_checks(:three)

    sign_in users(:one)
  end

  test 'should create check' do
    assert_difference('::Repository::Check.count') do
      post repository_checks_url(@repository),
           params: {
             repository: {
               id: @repository.id,
               full_name: @repository.full_name
             }
           }
    end
  end

  test 'should show' do
    get repository_check_url(@repository.id, @check.id)

    assert_response :success
  end
end
