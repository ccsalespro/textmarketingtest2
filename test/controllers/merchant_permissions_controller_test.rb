require 'test_helper'

class MerchantPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant_permission = merchant_permissions(:one)
  end

  test "should get index" do
    get merchant_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_merchant_permission_url
    assert_response :success
  end

  test "should create merchant_permission" do
    assert_difference('MerchantPermission.count') do
      post merchant_permissions_url, params: { merchant_permission: { name: @merchant_permission.name } }
    end

    assert_redirected_to merchant_permission_url(MerchantPermission.last)
  end

  test "should show merchant_permission" do
    get merchant_permission_url(@merchant_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_merchant_permission_url(@merchant_permission)
    assert_response :success
  end

  test "should update merchant_permission" do
    patch merchant_permission_url(@merchant_permission), params: { merchant_permission: { name: @merchant_permission.name } }
    assert_redirected_to merchant_permission_url(@merchant_permission)
  end

  test "should destroy merchant_permission" do
    assert_difference('MerchantPermission.count', -1) do
      delete merchant_permission_url(@merchant_permission)
    end

    assert_redirected_to merchant_permissions_url
  end
end
