require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get people" do
    get search_people_url
    assert_response :success
  end

  test "should get :id" do
    get search_:id_url
    assert_response :success
  end

end
