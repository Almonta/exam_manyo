class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  has_many :tasks, dependent: :destroy

  # before_create :ensure_has_name
  # private
  # def ensure_has_name
  #   puts "nameの値をTaroに設定します！"
  #   self.name = 'Taro' if name.blank?
  # end

  before_destroy :destroy_admin
  before_update :update_admin
  private
  def destroy_admin
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end
  def update_admin
    if User.where(admin: true).count == 1 && self.admin == true
      throw(:abort)
    end
  end

end
