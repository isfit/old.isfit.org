require 'test_helper'

class ProjectSupportsControllerTest < ActionController::TestCase
  setup do
    @project_support = project_supports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:project_supports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project_support" do
    assert_difference('ProjectSupport.count') do
      post :create, :project_support => @project_support.attributes
    end

    assert_redirected_to project_support_path(assigns(:project_support))
  end

  test "should show project_support" do
    get :show, :id => @project_support.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @project_support.to_param
    assert_response :success
  end

  test "should update project_support" do
    put :update, :id => @project_support.to_param, :project_support => @project_support.attributes
    assert_redirected_to project_support_path(assigns(:project_support))
  end

  test "should destroy project_support" do
    assert_difference('ProjectSupport.count', -1) do
      delete :destroy, :id => @project_support.to_param
    end

    assert_redirected_to project_supports_path
  end
end
