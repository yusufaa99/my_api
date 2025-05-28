require "test_helper"

class Api::V1::MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get matches_index_url
    assert_response :success
  end

  test "should get show" do
    get matches_show_url
    assert_response :success
  end

  test "should get create" do
    get matches_create_url
    assert_response :success
  end

  test "should get update" do
    get matches_update_url
    assert_response :success
  end

  test "should get destroy" do
    get matches_destroy_url
    assert_response :success
  end
end
