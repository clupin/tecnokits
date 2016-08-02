class Product < ActiveRecord::Base
	has_many :product_attachments
	has_many :product_categories
	has_many :categories, through: :product_categories
	accepts_nested_attributes_for :product_attachments
	after_create :save_categories

	def categories=(value)
		@categories = value
	end

	def save_categories
		@categories.each do |category_id|
			ProductCategory.create(category_id: category_id, product_id: self.id)
		end
	end

	def update_attachments(params)
      self.product_attachments.each(&:destroy) if self.product_attachments.present?
      params[:product_attachments]['image'].each do |image|
        self.product_attachments.create!(:image => image)
      end
    end
end
