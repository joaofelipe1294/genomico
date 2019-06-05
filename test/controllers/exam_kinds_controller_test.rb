require 'test_helper'

class ExamKindsControllerTest < ActionController::TestCase
  setup do
    @exam_kind = exam_kinds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exam_kinds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exam_kind" do
    assert_difference('ExamKind.count') do
      post :create, exam_kind: { field_id: @exam_kind.field_id, is_active: @exam_kind.is_active, name: @exam_kind.name }
    end

    assert_redirected_to exam_kind_path(assigns(:exam_kind))
  end

  test "should show exam_kind" do
    get :show, id: @exam_kind
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exam_kind
    assert_response :success
  end

  test "should update exam_kind" do
    patch :update, id: @exam_kind, exam_kind: { field_id: @exam_kind.field_id, is_active: @exam_kind.is_active, name: @exam_kind.name }
    assert_redirected_to exam_kind_path(assigns(:exam_kind))
  end

  test "should destroy exam_kind" do
    assert_difference('ExamKind.count', -1) do
      delete :destroy, id: @exam_kind
    end

    assert_redirected_to exam_kinds_path
  end
end
