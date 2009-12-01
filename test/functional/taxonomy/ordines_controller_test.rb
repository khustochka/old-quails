require 'test_helper'

class OrdinesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:taxa)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordo" do
    assert_difference('Ordo.count') do
      post :create, :ordo => { :name_la => "Midiformes", :name_ru => "Среднеобразные", :name_uk => "Середньоподібні", :description => '', :sort => Ordo.count / 2 }
    end

    assert_redirected_to ordo_path(assigns(:taxon))
  end

  test "should show ordo" do
    get :show, :id => ordines(:ordines_014).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ordines(:ordines_014).to_param
    assert_response :redirect
    assert_redirected_to ordo_path(ordines(:ordines_014))
  end

  test "should update ordo" do
    put :update, :id => ordines(:ordines_014).to_param, :ordo => { :name_la => "Insertiformes", :name_ru => "Заменообразные", :name_uk => "Заміноподібні", :sort => Ordo.count / 3 }
    assert_redirected_to ordo_path(assigns(:taxon))
  end

  test "should destroy ordo" do
    assert_difference('Ordo.count', -1) do
      delete :destroy, :id => ordines(:ordines_014).to_param
    end

    assert_redirected_to ordines_path
  end
end
