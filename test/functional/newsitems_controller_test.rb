require 'test_helper'

class NewsitemsControllerTest < ActionController::TestCase
  setup do
    @newsitem = newsitems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsitems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsitem" do
    assert_difference('Newsitem.count') do
      post :create, newsitem: @newsitem.attributes
    end

    assert_redirected_to newsitem_path(assigns(:newsitem))
  end

  test "should show newsitem" do
    get :show, id: @newsitem.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newsitem.to_param
    assert_response :success
  end

  test "should update newsitem" do
    put :update, id: @newsitem.to_param, newsitem: @newsitem.attributes
    assert_redirected_to newsitem_path(assigns(:newsitem))
  end

  test "should destroy newsitem" do
    assert_difference('Newsitem.count', -1) do
      delete :destroy, id: @newsitem.to_param
    end

    assert_redirected_to newsitems_path
  end
end
