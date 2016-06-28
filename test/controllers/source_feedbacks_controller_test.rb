require 'test_helper'

class SourceFeedbacksControllerTest < ActionController::TestCase
  setup do
    @source_feedback = source_feedbacks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_feedbacks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_feedback" do
    assert_difference('SourceFeedback.count') do
      post :create, source_feedback: { feedback_type_id: @source_feedback.feedback_type_id, professional_id: @source_feedback.professional_id, professional_profession_id: @source_feedback.professional_profession_id, professional_profession_service_id: @source_feedback.professional_profession_service_id }
    end

    assert_redirected_to source_feedback_path(assigns(:source_feedback))
  end

  test "should show source_feedback" do
    get :show, id: @source_feedback
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_feedback
    assert_response :success
  end

  test "should update source_feedback" do
    patch :update, id: @source_feedback, source_feedback: { feedback_type_id: @source_feedback.feedback_type_id, professional_id: @source_feedback.professional_id, professional_profession_id: @source_feedback.professional_profession_id, professional_profession_service_id: @source_feedback.professional_profession_service_id }
    assert_redirected_to source_feedback_path(assigns(:source_feedback))
  end

  test "should destroy source_feedback" do
    assert_difference('SourceFeedback.count', -1) do
      delete :destroy, id: @source_feedback
    end

    assert_redirected_to source_feedbacks_path
  end
end
