class Task < ApplicationRecord
  # validates :task_name, :details, :deadline, presence: true
  # deadlineのバリデーションを廃止した
  validates :task_name, :details, presence: true
  # validates :details, presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
  enum priority: { 高:1, 中:2, 低:3 }
  

  # scope :search_task_name, -> { where("task_name LIKE ?", "%#{params[:search]}%") }

  scope :search_task_name, -> (search) { where("task_name LIKE ?", "%#{search}%")}

  scope :search_status, -> (search) { where(status: search) }

  scope :by_created_at, -> { order(created_at: :desc) }

end
