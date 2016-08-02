class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show, :index] 

  respond_to :html

  def index
    @products = Product.paginate(page: params[:page], per_page: 6)
    respond_with(@products)
  end

  def show
    @product_attachments = @product.product_attachments.all
  end


  def new
    @product = Product.new
    @product_attachment = @product.product_attachments.build
    @categories = Category.all
  end

  def edit
    @product_attachment = @product.product_attachments.build
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.categories = params[:categories]
    if @product.save
      params[:product_attachments]['image'].each do |i|
          @product_attachment = @product.product_attachments.create!(:image => i)
      end
      respond_with(@product)
    else
      format.html { render action: 'new' }
    end
  end

  def update
    @product.update_attachments(params) if params[:product_attachments]
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :mini_description, :price, :discount, :categories, product_attachments_attributes: [:id, :product_id, :image])
    end

    
end
