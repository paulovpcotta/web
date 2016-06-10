require 'test_helper'

class ProfessionalProfessionServicesControllerTest < ActionController::TestCase
  setup do
    @professional_profession_service = professional_profession_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:professional_profession_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create professional_profession_service" do
    assert_difference('ProfessionalProfessionService.count') do
      post :create, professional_profession_service: { active: @professional_profession_service.active, excluded_at: @professional_profession_service.excluded_at, price: @professional_profession_service.price, professional_profession_id: @professional_profession_service.professional_profession_id, service_id: @professional_profession_service.service_id, service_unit_id: @professional_profession_service.service_unit_id }
    end

    assert_redirected_to professional_profession_service_path(assigns(:professional_profession_service))
  end

  test "should show professional_profession_service" do
    get :show, id: @professional_profession_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @professional_profession_service
    assert_response :success
  end

  test "should update professional_profession_service" do
    patch :update, id: @professional_profession_service, professional_profession_service: { active: @professional_profession_service.active, excluded_at: @professional_profession_service.excluded_at, price: @professional_profession_service.price, professional_profession_id: @professional_profession_service.professional_profession_id, service_id: @professional_profession_service.service_id, service_unit_id: @professional_profession_service.service_unit_id }
    assert_redirected_to professional_profession_service_path(assigns(:professional_profession_service))
  end

  test "should destroy professional_profession_service" do
    assert_difference('ProfessionalProfessionService.count', -1) do
      delete :destroy, id: @professional_profession_service
    end

    assert_redirected_to professional_profession_services_path
  end
end
