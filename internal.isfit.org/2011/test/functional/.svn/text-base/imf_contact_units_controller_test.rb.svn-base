require 'test_helper'

class ImfContactUnitsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:imf_contact_units)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_imf_contact_unit
    assert_difference('ImfContactUnit.count') do
      post :create, :imf_contact_unit => { }
    end

    assert_redirected_to imf_contact_unit_path(assigns(:imf_contact_unit))
  end

  def test_should_show_imf_contact_unit
    get :show, :id => imf_contact_units(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => imf_contact_units(:one).id
    assert_response :success
  end

  def test_should_update_imf_contact_unit
    put :update, :id => imf_contact_units(:one).id, :imf_contact_unit => { }
    assert_redirected_to imf_contact_unit_path(assigns(:imf_contact_unit))
  end

  def test_should_destroy_imf_contact_unit
    assert_difference('ImfContactUnit.count', -1) do
      delete :destroy, :id => imf_contact_units(:one).id
    end

    assert_redirected_to imf_contact_units_path
  end
end
