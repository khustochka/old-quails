require 'test_helper'

class SomesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:somes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create some" do
    assert_difference('Some.count') do
      post :create, :some => { }
    end

    assert_redirected_to some_path(assigns(:some))
  end

  test "should show some" do
    get :show, :id => somes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => somes(:one).to_param
    assert_response :success
  end

  test "should update some" do
    put :update, :id => somes(:one).to_param, :some => { }
    assert_redirected_to some_path(assigns(:some))
  end

  test "should destroy some" do
    assert_difference('Some.count', -1) do
      delete :destroy, :id => somes(:one).to_param
    end

    assert_redirected_to somes_path
  end
end
