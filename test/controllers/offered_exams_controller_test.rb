require 'test_helper'

class OfferedExamsControllerTest < ActionController::TestCase
  setup do
    @offered_exam = offered_exams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offered_exams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offered_exam" do
    assert_difference('OfferedExam.count') do
      post :create, offered_exam: { field_id: @offered_exam.field_id, is_active: @offered_exam.is_active, name: @offered_exam.name }
    end

    assert_redirected_to offered_exam_path(assigns(:offered_exam))
  end

  test "should show offered_exam" do
    get :show, id: @offered_exam
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offered_exam
    assert_response :success
  end

  test "should update offered_exam" do
    patch :update, id: @offered_exam, offered_exam: { field_id: @offered_exam.field_id, is_active: @offered_exam.is_active, name: @offered_exam.name }
    assert_redirected_to offered_exam_path(assigns(:offered_exam))
  end

  test "should destroy offered_exam" do
    assert_difference('OfferedExam.count', -1) do
      delete :destroy, id: @offered_exam
    end

    assert_redirected_to offered_exams_path
  end
end
