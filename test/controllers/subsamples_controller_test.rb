require 'test_helper'

class SubsamplesControllerTest < ActionController::TestCase
  setup do
    @subsample = subsamples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subsamples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subsample" do
    assert_difference('Subsample.count') do
      post :create, subsample: { collection_date: @subsample.collection_date, refference_label: @subsample.refference_label, sample_id: @subsample.sample_id, storage_location: @subsample.storage_location, sub_sample_kind_id: @subsample.sub_sample_kind_id }
    end

    assert_redirected_to subsample_path(assigns(:subsample))
  end

  test "should show subsample" do
    get :show, id: @subsample
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subsample
    assert_response :success
  end

  test "should update subsample" do
    patch :update, id: @subsample, subsample: { collection_date: @subsample.collection_date, refference_label: @subsample.refference_label, sample_id: @subsample.sample_id, storage_location: @subsample.storage_location, sub_sample_kind_id: @subsample.sub_sample_kind_id }
    assert_redirected_to subsample_path(assigns(:subsample))
  end

  test "should destroy subsample" do
    assert_difference('Subsample.count', -1) do
      delete :destroy, id: @subsample
    end

    assert_redirected_to subsamples_path
  end
end
