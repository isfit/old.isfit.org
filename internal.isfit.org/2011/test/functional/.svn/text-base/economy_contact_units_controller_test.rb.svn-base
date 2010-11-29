require 'test_helper'

class EconomyContactUnitsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:economy_contact_units)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_economy_contact_unit
    assert_difference('EconomyContactUnit.count') do
      post :create, :economy_contact_unit => { }
    end

    assert_redirected_to economy_contact_unit_path(assigns(:economy_contact_unit))
  end

  def test_should_show_economy_contact_unit
    get :show, :id => economy_contact_units(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => economy_contact_units(:one).id
    assert_response :success
  end

  def test_should_update_economy_contact_unit
    put :update, :id => economy_contact_units(:one).id, :economy_contact_unit => { }
    assert_redirected_to economy_contact_unit_path(assigns(:economy_contact_unit))
  end

  def test_should_destroy_economy_contact_unit
    assert_difference('EconomyContactUnit.count', -1) do
      delete :destroy, :id => economy_contact_units(:one).id
    end

    assert_redirected_to economy_contact_units_path
  end
end
