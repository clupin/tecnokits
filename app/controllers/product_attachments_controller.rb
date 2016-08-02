class ProductAttachmentsController < ApplicationController
  before_action :set_product_attachment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show, :index] 

  respond_to :html

  def index
    @product_attachments = ProductAttachment.all
    respond_with(@product_attachments)
  end

  def show
    respond_with(@product_attachment)
  end

  def new
    @product_attachment = ProductAttachment.new
    respond_with(@product_attachment)
  end

  def edit
  end

  def create
    @product_attachment = ProductAttachment.new(product_attachment_params)
    @product_attachment.save
    respond_with(@product_attachment)
  end

  def update
    if @product_attachment.update(product_attachment_params)
      respond_with(@product_attachment)
    end
  end

  def destroy
    @product_attachment.destroy
    respond_with(@product_attachment)
  end

  private
    def set_product_attachment
      @product_attachment = ProductAttachment.find(params[:id])
    end

    def product_attachment_params
      params.require(:product_attachment).permit(:product_id, :image, :principal)
    end
end
