require 'test_helper'

class TaxaControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxa)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taxon" do
    assert_difference('Taxon.count') do
      post :create, :taxon => { }
    end

    assert_redirected_to taxon_path(assigns(:taxon))
  end

  test "should show taxon" do
    get :show, :id => taxa(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => taxa(:one).to_param
    assert_response :success
  end

  test "should update taxon" do
    put :update, :id => taxa(:one).to_param, :taxon => { }
    assert_redirected_to taxon_path(assigns(:taxon))
  end

  test "should destroy taxon" do
    assert_difference('Taxon.count', -1) do
      delete :destroy, :id => taxa(:one).to_param
    end

    assert_redirected_to taxa_path
  end
end
