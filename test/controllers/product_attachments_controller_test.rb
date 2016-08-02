require 'test_helper'

class ProductAttachmentsControllerTest < ActionController::TestCase
  setup do
    @product_attachment = product_attachments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_attachments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_attachment" do
    assert_difference('ProductAttachment.count') do
      post :create, product_attachment: { image: @product_attachment.image, principal: @product_attachment.principal, product_id: @product_attachment.product_id }
    end

    assert_redirected_to product_attachment_path(assigns(:product_attachment))
  end

  test "should show product_attachment" do
    get :show, id: @product_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_attachment
    assert_response :success
  end

  test "should update product_attachment" do
    patch :update, id: @product_attachment, product_attachment: { image: @product_attachment.image, principal: @product_attachment.principal, product_id: @product_attachment.product_id }
    assert_redirected_to product_attachment_path(assigns(:product_attachment))
  end

  test "should destroy product_attachment" do
    assert_difference('ProductAttachment.count', -1) do
      delete :destroy, id: @product_attachment
    end

    assert_redirected_to product_attachments_path
  end
end
