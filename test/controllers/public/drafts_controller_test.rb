require "test_helper"

class Public::DraftsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_drafts_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_drafts_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get public_drafts_destroy_url
    assert_response :success
  end
end
