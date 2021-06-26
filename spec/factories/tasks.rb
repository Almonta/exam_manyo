FactoryBot.define do

  factory :task do
    association :user
    task_name { 'test_task1' }
    details { 'test_content1' }
    deadline { '2021-06-22' }
    status { '完了' }
    priority { '高' }
  end
  
  factory :second_task, class: Task do
    task_name { 'test_task2' }
    details { 'test_content2' }
    deadline { '2022-07-23' }
    status { '着手中' }
    priority { '中' }
    # association :user, factory: :
  end

  factory :third_task, class: Task do
    task_name { 'test_task3' }
    details { 'test_content3' }
    deadline { '2023-08-24' }
    status { '未着手' }
    priority { '低' }
    # association :user
  end

end