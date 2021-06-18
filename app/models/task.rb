class Task < ApplicationRecord
  validates :task_name, :details, presence: true
  # validates :details, presence: true
end
