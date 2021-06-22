FactoryBot.define do

  factory :task do
    task_name { 'manyo' }
    details { 'manyokadai' }
    deadline { '2021-06-22' }
    status { '着手中' }
  end
  
  factory :second_task, class: Task do
    task_name { 'monyo' }
    details { 'monyokadai' }
    deadline { '2022-07-23' }
    status { '未着手' }
  end

end