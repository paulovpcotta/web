require 'test_helper'

class ProfessionalServicesControllerTest < ActionController::TestCase
  setup do
    @professional_service = professional_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professional_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professional_service" do
    assert_difference('ProfessionalService.count') do
      post :create, professional_service: { active: @professional_service.active, description: @professional_service.description, price: @professional_service.price, service_id: @professional_service.service_id, title: @professional_service.title, user_id: @professional_service.user_id }
    end

    assert_redirected_to professional_service_path(assigns(:professional_service))
  end

  test "should show professional_service" do
    get :show, id: @professional_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @professional_service
    assert_response :success
  end

  test "should update professional_service" do
    patch :update, id: @professional_service, professional_service: { active: @professional_service.active, description: @professional_service.description, price: @professional_service.price, service_id: @professional_service.service_id, title: @professional_service.title, user_id: @professional_service.user_id }
    assert_redirected_to professional_service_path(assigns(:professional_service))
  end

  test "should destroy professional_service" do
    assert_difference('ProfessionalService.count', -1) do
      delete :destroy, id: @professional_service
    end

    assert_redirected_to professional_services_path
  end
end
