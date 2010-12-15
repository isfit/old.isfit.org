require 'test_helper'

class EconomyContactPeopleControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:economy_contact_people)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_economy_contact_person
    assert_difference('EconomyContactPerson.count') do
      post :create, :economy_contact_person => { }
    end

    assert_redirected_to economy_contact_person_path(assigns(:economy_contact_person))
  end

  def test_should_show_economy_contact_person
    get :show, :id => economy_contact_people(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => economy_contact_people(:one).id
    assert_response :success
  end

  def test_should_update_economy_contact_person
    put :update, :id => economy_contact_people(:one).id, :economy_contact_person => { }
    assert_redirected_to economy_contact_person_path(assigns(:economy_contact_person))
  end

  def test_should_destroy_economy_contact_person
    assert_difference('EconomyContactPerson.count', -1) do
      delete :destroy, :id => economy_contact_people(:one).id
    end

    assert_redirected_to economy_contact_people_path
  end
end
