require 'test_helper'

class FamiliaeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:familiae)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create familia" do
    assert_difference('Familia.count') do
      post :create, :familia => { }
    end

    assert_redirected_to familia_path(assigns(:familia))
  end

  test "should show familia" do
    get :show, :id => familiae(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => familiae(:one).to_param
    assert_response :success
  end

  test "should update familia" do
    put :update, :id => familiae(:one).to_param, :familia => { }
    assert_redirected_to familia_path(assigns(:familia))
  end

  test "should destroy familia" do
    assert_difference('Familia.count', -1) do
      delete :destroy, :id => familiae(:one).to_param
    end

    assert_redirected_to familiae_path
  end
end
