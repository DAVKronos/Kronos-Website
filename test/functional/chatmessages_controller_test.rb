require 'test_helper'

class ChatmessagesControllerTest < ActionController::TestCase
  setup do
    @chatmessage = chatmessages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chatmessages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chatmessage" do
    assert_difference('Chatmessage.count') do
      post :create, chatmessage: @chatmessage.attributes
    end

    assert_redirected_to chatmessage_path(assigns(:chatmessage))
  end

  test "should show chatmessage" do
    get :show, id: @chatmessage.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chatmessage.to_param
    assert_response :success
  end

  test "should update chatmessage" do
    put :update, id: @chatmessage.to_param, chatmessage: @chatmessage.attributes
    assert_redirected_to chatmessage_path(assigns(:chatmessage))
  end

  test "should destroy chatmessage" do
    assert_difference('Chatmessage.count', -1) do
      delete :destroy, id: @chatmessage.to_param
    end

    assert_redirected_to chatmessages_path
  end
end
