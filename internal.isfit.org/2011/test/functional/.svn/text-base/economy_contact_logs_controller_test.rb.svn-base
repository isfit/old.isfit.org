require 'test_helper'

class EconomyContactLogsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:economy_contact_logs)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_economy_contact_log
    assert_difference('EconomyContactLog.count') do
      post :create, :economy_contact_log => { }
    end

    assert_redirected_to economy_contact_log_path(assigns(:economy_contact_log))
  end

  def test_should_show_economy_contact_log
    get :show, :id => economy_contact_logs(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => economy_contact_logs(:one).id
    assert_response :success
  end

  def test_should_update_economy_contact_log
    put :update, :id => economy_contact_logs(:one).id, :economy_contact_log => { }
    assert_redirected_to economy_contact_log_path(assigns(:economy_contact_log))
  end

  def test_should_destroy_economy_contact_log
    assert_difference('EconomyContactLog.count', -1) do
      delete :destroy, :id => economy_contact_logs(:one).id
    end

    assert_redirected_to economy_contact_logs_path
  end
end
