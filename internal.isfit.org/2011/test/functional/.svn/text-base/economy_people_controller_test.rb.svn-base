require 'test_helper'

class EconomyPeopleControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:economy_people)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_economy_person
    assert_difference('EconomyPerson.count') do
      post :create, :economy_person => { }
    end

    assert_redirected_to economy_person_path(assigns(:economy_person))
  end

  def test_should_show_economy_person
    get :show, :id => economy_people(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => economy_people(:one).id
    assert_response :success
  end

  def test_should_update_economy_person
    put :update, :id => economy_people(:one).id, :economy_person => { }
    assert_redirected_to economy_person_path(assigns(:economy_person))
  end

  def test_should_destroy_economy_person
    assert_difference('EconomyPerson.count', -1) do
      delete :destroy, :id => economy_people(:one).id
    end

    assert_redirected_to economy_people_path
  end
end
