require 'test_helper'

class KmlsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kmls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kml" do
    assert_difference('Kml.count') do
      post :create, :kml => { :description => 'description', :source_url => 'source_url' }
    end

    assert_redirected_to kml_path(assigns(:kml))
  end

  test "should show kml" do
    get :show, :id => kmls(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => kmls(:one).to_param
    assert_response :success
  end

  test "should update kml" do
    put :update, {:id => kmls(:one).to_param, :kml => { :description => 'updated', :source_url => 'foo', :original_filename => '' }}
    assert_redirected_to kml_path(assigns(:kml))
  end

  test "should destroy kml" do
    assert_difference('Kml.count', -1) do
      delete :destroy, :id => kmls(:one).to_param
    end

    assert_redirected_to kmls_path
  end
end
