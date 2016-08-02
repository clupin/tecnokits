class ProductAttachment < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :product
	before_create :set_principal

	private

	def set_principal
		self.principal = true
	end
end
