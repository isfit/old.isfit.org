require 'test_helper'

class EconomyContactUnitTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:economy_contact_unit_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_economy_contact_unit_type
    assert_difference('EconomyContactUnitType.count') do
      post :create, :economy_contact_unit_type => { }
    end

    assert_redirected_to economy_contact_unit_type_path(assigns(:economy_contact_unit_type))
  end

  def test_should_show_economy_contact_unit_type
    get :show, :id => economy_contact_unit_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => economy_contact_unit_types(:one).id
    assert_response :success
  end

  def test_should_update_economy_contact_unit_type
    put :update, :id => economy_contact_unit_types(:one).id, :economy_contact_unit_type => { }
    assert_redirected_to economy_contact_unit_type_path(assigns(:economy_contact_unit_type))
  end

  def test_should_destroy_economy_contact_unit_type
    assert_difference('EconomyContactUnitType.count', -1) do
      delete :destroy, :id => economy_contact_unit_types(:one).id
    end

    assert_redirected_to economy_contact_unit_types_path
  end
end
