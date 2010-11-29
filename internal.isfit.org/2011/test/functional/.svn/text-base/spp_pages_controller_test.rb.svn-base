require 'test_helper'

class SppPagesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:spp_pages)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_spp_page
    assert_difference('SppPage.count') do
      post :create, :spp_page => { }
    end

    assert_redirected_to spp_page_path(assigns(:spp_page))
  end

  def test_should_show_spp_page
    get :show, :id => spp_pages(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => spp_pages(:one).id
    assert_response :success
  end

  def test_should_update_spp_page
    put :update, :id => spp_pages(:one).id, :spp_page => { }
    assert_redirected_to spp_page_path(assigns(:spp_page))
  end

  def test_should_destroy_spp_page
    assert_difference('SppPage.count', -1) do
      delete :destroy, :id => spp_pages(:one).id
    end

    assert_redirected_to spp_pages_path
  end
end
