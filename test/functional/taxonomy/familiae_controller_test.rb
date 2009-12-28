require 'test/test_helper'

class FamiliaeControllerTest < ActionController::TestCase

  test "should get index" do
    http_auth
    get :index
    assert_response :success
    assert_not_nil assigns(:bunch)
  end

  test "should get new" do
    http_auth
    get :new
    assert_response :success
  end

  test "should create familia" do
    http_auth
    assert_difference('Familia.count') do
      post :create, :familia => { :name_la => "Mididae", :name_ru => "Средневые", :name_uk => "Середньові", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => Familia.count / 2 }
    end
    assert_redirected_to familia_path(assigns(:taxon))
  end

  test "should show familia" do
    http_auth
    get :show, :id => familiae(:familiae_014).to_param
    assert_response :success
  end

  test "should get edit" do
    http_auth
    get :edit, :id => familiae(:familiae_014).to_param
    assert_response :redirect
    assert_redirected_to familia_path(familiae(:familiae_014))
  end

  test "should update familia" do
    http_auth
    post :update, :id => familiae(:familiae_014).to_param, :familia => { :name_la => "Insertidae", :name_ru => "Вставные", :name_uk => "Вставні", :sort => Familia.count / 3 }
    assert_redirected_to familia_path(assigns(:taxon))
  end

  test "should destroy familia" do
    http_auth
    assert_difference('Familia.count', -1) do
      delete :destroy, :id => familiae(:familiae_014).to_param
    end
    assert_redirected_to familiae_path
  end

# Restriction tests

  test "not admin should not get index" do
    get :index
    assert_response :not_found
  end

  test "not admin should not get new" do
    get :new
    assert_response :not_found
  end

  test "not admin should not create familia" do
    assert_difference('Familia.count', 0) do
      post :create, :familia => { :name_la => "Mididae", :name_ru => "Средневые", :name_uk => "Середневі", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => Familia.count / 2 }
    end
    assert_response :not_found
  end

  test "not admin should not show familia" do
    get :show, :id => familiae(:familiae_014).to_param
    assert_response :not_found
  end

  test "not admin should not get edit" do
    get :edit, :id => familiae(:familiae_014).to_param
    assert_response :not_found
  end

  test "not admin should not update familia" do
    post :update, :id => familiae(:familiae_014).to_param, :familia => { :name_la => "Insertidae", :name_ru => "Вставные", :name_uk => "Вставні", :sort => Familia.count / 3 }
    assert_response :not_found
  end

  test "not admin should not destroy familia" do
    assert_difference('Familia.count', 0) do
      delete :destroy, :id => familiae(:familiae_014).to_param
    end
    assert_response :not_found
  end
end
