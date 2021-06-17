class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :details, presence: true
end
