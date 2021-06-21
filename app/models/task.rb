class Task < ApplicationRecord
  validates :task_name, :details, :deadline, presence: true
  # validates :details, presence: true
  enum status: { 未着手:1, 着手中:2, 完了:3 }
end
