class Task < ApplicationRecord
  validates :task_name, :details, :deadline, presence: true
  # validates :details, presence: true
end
