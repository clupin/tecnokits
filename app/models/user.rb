class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	mount_uploader :avatar, AvatarUploader
	before_create :set_permission



	include PermissionsConcern

	private

	def set_permission
		self.permission_level = 1
	end
end
