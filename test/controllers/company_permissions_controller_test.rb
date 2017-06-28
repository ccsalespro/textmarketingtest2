require 'test_helper'

class CompanyPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_permission = company_permissions(:one)
  end

  test "should get index" do
    get company_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_company_permission_url
    assert_response :success
  end

  test "should create company_permission" do
    assert_difference('CompanyPermission.count') do
      post company_permissions_url, params: { company_permission: { name: @company_permission.name } }
    end

    assert_redirected_to company_permission_url(CompanyPermission.last)
  end

  test "should show company_permission" do
    get company_permission_url(@company_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_permission_url(@company_permission)
    assert_response :success
  end

  test "should update company_permission" do
    patch company_permission_url(@company_permission), params: { company_permission: { name: @company_permission.name } }
    assert_redirected_to company_permission_url(@company_permission)
  end

  test "should destroy company_permission" do
    assert_difference('CompanyPermission.count', -1) do
      delete company_permission_url(@company_permission)
    end

    assert_redirected_to company_permissions_url
  end
end
