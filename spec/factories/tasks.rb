FactoryBot.define do

  factory :task do
    task_name { 'manyo' }
    details { 'manyokadai' }
    deadline { '2021-06-20'}
  end
  
  factory :second_task, class: Task do
    task_name { 'monyo' }
    details { 'monyokadai' }
  end

end