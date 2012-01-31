require 'test_helper'

class EventtypesControllerTest < ActionController::TestCase
  setup do
    @eventtype = eventtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eventtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eventtype" do
    assert_difference('Eventtype.count') do
      post :create, eventtype: @eventtype.attributes
    end

    assert_redirected_to eventtype_path(assigns(:eventtype))
  end

  test "should show eventtype" do
    get :show, id: @eventtype.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eventtype.to_param
    assert_response :success
  end

  test "should update eventtype" do
    put :update, id: @eventtype.to_param, eventtype: @eventtype.attributes
    assert_redirected_to eventtype_path(assigns(:eventtype))
  end

  test "should destroy eventtype" do
    assert_difference('Eventtype.count', -1) do
      delete :destroy, id: @eventtype.to_param
    end

    assert_redirected_to eventtypes_path
  end
end
