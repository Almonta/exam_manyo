class Task < ApplicationRecord
  validates :task_name, :details, presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 高:1, 中:2, 低:3 }
  
  scope :search_task_name, -> (search) { where("task_name LIKE ?", "%#{search}%")}
  scope :search_status, -> (search) { where(status: search) }
  scope :by_created_at, -> { order(created_at: :desc) }

  belongs_to :user

  has_many :label_links, dependent: :destroy
  has_many :labels, through: :label_links

end
