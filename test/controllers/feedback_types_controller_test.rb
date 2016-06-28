require 'test_helper'

class FeedbackTypesControllerTest < ActionController::TestCase
  setup do
    @feedback_type = feedback_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feedback_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feedback_type" do
    assert_difference('FeedbackType.count') do
      post :create, feedback_type: { active: @feedback_type.active, description: @feedback_type.description, name: @feedback_type.name }
    end

    assert_redirected_to feedback_type_path(assigns(:feedback_type))
  end

  test "should show feedback_type" do
    get :show, id: @feedback_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feedback_type
    assert_response :success
  end

  test "should update feedback_type" do
    patch :update, id: @feedback_type, feedback_type: { active: @feedback_type.active, description: @feedback_type.description, name: @feedback_type.name }
    assert_redirected_to feedback_type_path(assigns(:feedback_type))
  end

  test "should destroy feedback_type" do
    assert_difference('FeedbackType.count', -1) do
      delete :destroy, id: @feedback_type
    end

    assert_redirected_to feedback_types_path
  end
end
