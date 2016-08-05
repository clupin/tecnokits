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
    update_categories
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

    def update_categories
      @cat = Category.all
      @newcategories = params[:categories]
      @cat.each do |c|
        #si no hay nuevas categorias
        if @newcategories.nil?
          #categorias existentes
          if @product.categories.include?(c)
            #si es una categoria que se tenia, pero no se quiere agregar, entonces se quita
            @dest = ProductCategory.where(:category_id => c.id, :product_id => @product.id).destroy_all
          end
        #si existe una nueva lista de categorias
        else
          #nuevas categorias
          if @newcategories.include?(c.id.to_s)
            #categorias existentes
            if @product.categories.include?(c)
              #si es una categoria que se quiere agregar y ademas existe (es decir, se quiere mantener), no se hace nada
            else
              #si es una categoria que se quiere agregar, pero no existe, entonces se agrega
              ProductCategory.create(category_id: c.id, product_id: @product.id)
            end
          #categorias que no se quieren agregar
          else
            #categorias existentes
            if @product.categories.include?(c)
              #si es una categoria que se tenia, pero no se quiere agregar, entonces se quita
              @dest = ProductCategory.where(:category_id => c.id, :product_id => @product.id).destroy_all
            end
          end
        end
      end
    end

    
end
