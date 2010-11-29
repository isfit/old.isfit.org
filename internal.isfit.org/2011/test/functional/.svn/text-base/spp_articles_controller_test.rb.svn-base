require 'test_helper'

class SppArticlesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:spp_articles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_spp_article
    assert_difference('SppArticle.count') do
      post :create, :spp_article => { }
    end

    assert_redirected_to spp_article_path(assigns(:spp_article))
  end

  def test_should_show_spp_article
    get :show, :id => spp_articles(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => spp_articles(:one).id
    assert_response :success
  end

  def test_should_update_spp_article
    put :update, :id => spp_articles(:one).id, :spp_article => { }
    assert_redirected_to spp_article_path(assigns(:spp_article))
  end

  def test_should_destroy_spp_article
    assert_difference('SppArticle.count', -1) do
      delete :destroy, :id => spp_articles(:one).id
    end

    assert_redirected_to spp_articles_path
  end
end
