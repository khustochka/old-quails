require 'test_helper'

class OrdinesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordo" do
    assert_difference('Ordo.count') do
      post :create, :ordo => { }
    end

    assert_redirected_to ordo_path(assigns(:ordo))
  end

  test "should show ordo" do
    get :show, :id => ordines(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ordines(:one).to_param
    assert_response :success
  end

  test "should update ordo" do
    put :update, :id => ordines(:one).to_param, :ordo => { }
    assert_redirected_to ordo_path(assigns(:ordo))
  end

  test "should destroy ordo" do
    assert_difference('Ordo.count', -1) do
      delete :destroy, :id => ordines(:one).to_param
    end

    assert_redirected_to ordines_path
  end
end
