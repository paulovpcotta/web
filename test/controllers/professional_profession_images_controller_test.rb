require 'test_helper'

class ProfessionalProfessionImagesControllerTest < ActionController::TestCase
  setup do
    @professional_profession_image = professional_profession_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professional_profession_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professional_profession_image" do
    assert_difference('ProfessionalProfessionImage.count') do
      post :create, professional_profession_image: {  }
    end

    assert_redirected_to professional_profession_image_path(assigns(:professional_profession_image))
  end

  test "should show professional_profession_image" do
    get :show, id: @professional_profession_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @professional_profession_image
    assert_response :success
  end

  test "should update professional_profession_image" do
    patch :update, id: @professional_profession_image, professional_profession_image: {  }
    assert_redirected_to professional_profession_image_path(assigns(:professional_profession_image))
  end

  test "should destroy professional_profession_image" do
    assert_difference('ProfessionalProfessionImage.count', -1) do
      delete :destroy, id: @professional_profession_image
    end

    assert_redirected_to professional_profession_images_path
  end
end
