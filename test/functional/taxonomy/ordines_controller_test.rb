#require 'test/test_helper'
#
#class OrdinesControllerTest < ActionController::TestCase
#
#  test "should get index" do
#    http_auth
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:bunch)
#  end
#
#  test "should get new" do
#    http_auth
#    get :new
#    assert_response :success
#  end
#
#  test "should create ordo" do
#    http_auth
#    assert_difference('Ordo.count') do
#      post :create, :ordo => { :name_la => "Midiformes", :name_ru => "Среднеобразные", :name_uk => "Середньоподібні", :description => '', :sort => Ordo.count / 2 }
#    end
#    assert_redirected_to ordo_path(assigns(:taxon))
#  end
#
#  test "should show ordo" do
#    http_auth
#    get :show, :id => ordines(:ordines_014).to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    http_auth
#    get :edit, :id => ordines(:ordines_014).to_param
#    assert_response :redirect
#    assert_redirected_to ordo_path(ordines(:ordines_014))
#  end
#
#  test "should update ordo" do
#    http_auth
#    post :update, :id => ordines(:ordines_014).to_param, :ordo => { :name_la => "Insertiformes", :name_ru => "Заменообразные", :name_uk => "Заміноподібні", :sort => Ordo.count / 3 }
#    assert_redirected_to ordo_path(assigns(:taxon))
#  end
#
#  test "should destroy ordo" do
#    http_auth
#    assert_difference('Ordo.count', -1) do
#      delete :destroy, :id => ordines(:ordines_014).to_param
#    end
#    assert_redirected_to ordines_path
#  end
#
## Restriction tests
#
#  test "not admin should not get index" do
#    get :index
#    assert_response :not_found
#  end
#
#  test "not admin should not get new" do
#    get :new
#    assert_response :not_found
#  end
#
#  test "not admin should not create ordo" do
#    assert_difference('Ordo.count', 0) do
#      post :create, :ordo => { :name_la => "Midiformes", :name_ru => "Среднеобразные", :name_uk => "Середньоподібні", :description => '', :sort => Ordo.count / 2 }
#    end
#    assert_response :not_found
#  end
#
#  test "not admin should not show ordo" do
#    get :show, :id => ordines(:ordines_014).to_param
#    assert_response :not_found
#  end
#
#  test "not admin should not get edit" do
#    get :edit, :id => ordines(:ordines_014).to_param
#    assert_response :not_found
#  end
#
#  test "not admin should not update ordo" do
#    post :update, :id => ordines(:ordines_014).to_param, :ordo => { :name_la => "Insertiformes", :name_ru => "Заменообразные", :name_uk => "Заміноподібні", :sort => Ordo.count / 3 }
#    assert_response :not_found
#  end
#
#  test "not admin should not destroy ordo" do
#    assert_difference('Ordo.count', 0) do
#      delete :destroy, :id => ordines(:ordines_014).to_param
#    end
#    assert_response :not_found
#  end
#
#end
