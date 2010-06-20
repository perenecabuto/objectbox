require 'test_helper'

class SimpletextsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:simpletexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create simpletext" do
    assert_difference('Simpletext.count') do
      post :create, :simpletext => { }
    end

    assert_redirected_to simpletext_path(assigns(:simpletext))
  end

  test "should show simpletext" do
    get :show, :id => simpletexts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => simpletexts(:one).to_param
    assert_response :success
  end

  test "should update simpletext" do
    put :update, :id => simpletexts(:one).to_param, :simpletext => { }
    assert_redirected_to simpletext_path(assigns(:simpletext))
  end

  test "should destroy simpletext" do
    assert_difference('Simpletext.count', -1) do
      delete :destroy, :id => simpletexts(:one).to_param
    end

    assert_redirected_to simpletexts_path
  end
end
