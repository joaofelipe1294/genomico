require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase
  setup do
    @attendance = attendances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance" do
    assert_difference('Attendance.count') do
      post :create, attendance: { attendance_status_kind_id: @attendance.attendance_status_kind_id, cid_code: @attendance.cid_code, desease_stage_id: @attendance.desease_stage_id, doctor_crm: @attendance.doctor_crm, doctor_name: @attendance.doctor_name, finish_date: @attendance.finish_date, health_ensurance_id: @attendance.health_ensurance_id, lis_code: @attendance.lis_code, observations: @attendance.observations, patient_id: @attendance.patient_id, start_date: @attendance.start_date }
    end

    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should show attendance" do
    get :show, id: @attendance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendance
    assert_response :success
  end

  test "should update attendance" do
    patch :update, id: @attendance, attendance: { attendance_status_kind_id: @attendance.attendance_status_kind_id, cid_code: @attendance.cid_code, desease_stage_id: @attendance.desease_stage_id, doctor_crm: @attendance.doctor_crm, doctor_name: @attendance.doctor_name, finish_date: @attendance.finish_date, health_ensurance_id: @attendance.health_ensurance_id, lis_code: @attendance.lis_code, observations: @attendance.observations, patient_id: @attendance.patient_id, start_date: @attendance.start_date }
    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete :destroy, id: @attendance
    end

    assert_redirected_to attendances_path
  end
end
