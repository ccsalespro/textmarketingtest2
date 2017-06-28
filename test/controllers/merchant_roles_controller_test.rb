require 'test_helper'

class MerchantRolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant_role = merchant_roles(:one)
  end

  test "should get index" do
    get merchant_roles_url
    assert_response :success
  end

  test "should get new" do
    get new_merchant_role_url
    assert_response :success
  end

  test "should create merchant_role" do
    assert_difference('MerchantRole.count') do
      post merchant_roles_url, params: { merchant_role: { merchant_id: @merchant_role.merchant_id, name: @merchant_role.name } }
    end

    assert_redirected_to merchant_role_url(MerchantRole.last)
  end

  test "should show merchant_role" do
    get merchant_role_url(@merchant_role)
    assert_response :success
  end

  test "should get edit" do
    get edit_merchant_role_url(@merchant_role)
    assert_response :success
  end

  test "should update merchant_role" do
    patch merchant_role_url(@merchant_role), params: { merchant_role: { merchant_id: @merchant_role.merchant_id, name: @merchant_role.name } }
    assert_redirected_to merchant_role_url(@merchant_role)
  end

  test "should destroy merchant_role" do
    assert_difference('MerchantRole.count', -1) do
      delete merchant_role_url(@merchant_role)
    end

    assert_redirected_to merchant_roles_url
  end
end
