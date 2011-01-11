require 'test_helper'

class PressAccreditationsControllerTest < ActionController::TestCase
  setup do
    @press_accreditation = press_accreditations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:press_accreditations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create press_accreditation" do
    assert_difference('PressAccreditation.count') do
      post :create, :press_accreditation => @press_accreditation.attributes
    end

    assert_redirected_to press_accreditation_path(assigns(:press_accreditation))
  end

  test "should show press_accreditation" do
    get :show, :id => @press_accreditation.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @press_accreditation.to_param
    assert_response :success
  end

  test "should update press_accreditation" do
    put :update, :id => @press_accreditation.to_param, :press_accreditation => @press_accreditation.attributes
    assert_redirected_to press_accreditation_path(assigns(:press_accreditation))
  end

  test "should destroy press_accreditation" do
    assert_difference('PressAccreditation.count', -1) do
      delete :destroy, :id => @press_accreditation.to_param
    end

    assert_redirected_to press_accreditations_path
  end
end
