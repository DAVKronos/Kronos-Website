require 'test_helper'

class AgendaitemtypeEventtypesControllerTest < ActionController::TestCase
  setup do
    @agendaitemtype_eventtype = agendaitemtype_eventtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agendaitemtype_eventtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agendaitemtype_eventtype" do
    assert_difference('AgendaitemtypeEventtype.count') do
      post :create, agendaitemtype_eventtype: @agendaitemtype_eventtype.attributes
    end

    assert_redirected_to agendaitemtype_eventtype_path(assigns(:agendaitemtype_eventtype))
  end

  test "should show agendaitemtype_eventtype" do
    get :show, id: @agendaitemtype_eventtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agendaitemtype_eventtype
    assert_response :success
  end

  test "should update agendaitemtype_eventtype" do
    put :update, id: @agendaitemtype_eventtype, agendaitemtype_eventtype: @agendaitemtype_eventtype.attributes
    assert_redirected_to agendaitemtype_eventtype_path(assigns(:agendaitemtype_eventtype))
  end

  test "should destroy agendaitemtype_eventtype" do
    assert_difference('AgendaitemtypeEventtype.count', -1) do
      delete :destroy, id: @agendaitemtype_eventtype
    end

    assert_redirected_to agendaitemtype_eventtypes_path
  end
end
