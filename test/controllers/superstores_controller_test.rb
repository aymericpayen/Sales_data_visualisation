require "test_helper"

class SuperstoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superstores_index_url
    assert_response :success
  end
end
