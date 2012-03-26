require 'test_helper'

class AgendaitemtypesControllerTest < ActionController::TestCase
  setup do
    @agendaitemtype = agendaitemtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agendaitemtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agendaitemtype" do
    assert_difference('Agendaitemtype.count') do
      post :create, agendaitemtype: @agendaitemtype.attributes
    end

    assert_redirected_to agendaitemtype_path(assigns(:agendaitemtype))
  end

  test "should show agendaitemtype" do
    get :show, id: @agendaitemtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agendaitemtype
    assert_response :success
  end

  test "should update agendaitemtype" do
    put :update, id: @agendaitemtype, agendaitemtype: @agendaitemtype.attributes
    assert_redirected_to agendaitemtype_path(assigns(:agendaitemtype))
  end

  test "should destroy agendaitemtype" do
    assert_difference('Agendaitemtype.count', -1) do
      delete :destroy, id: @agendaitemtype
    end

    assert_redirected_to agendaitemtypes_path
  end
end
