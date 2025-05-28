require "test_helper"

class Api::V1::LeaguesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get leagues_index_url
    assert_response :success
  end

  test "should get show" do
    get leagues_show_url
    assert_response :success
  end

  test "should get create" do
    get leagues_create_url
    assert_response :success
  end

  test "should get update" do
    get leagues_update_url
    assert_response :success
  end

  test "should get destroy" do
    get leagues_destroy_url
    assert_response :success
  end
end
