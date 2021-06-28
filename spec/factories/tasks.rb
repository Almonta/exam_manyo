FactoryBot.define do

  factory :task do
    association :user
    task_name { 'test_task1' }
    details { 'test_content1' }
    deadline { '2021-06-22' }
    status { '完了' }
    priority { '高' }

    after(:build) do |task|
      label = create(:label)
      second_label = create(:second_label)
      third_label = create(:third_label)
      task.label_links << build(:label_link, task: task, label: second_label )
      # task.label_links << build(:label_link, task: task, label: label)
    end
  end
  
  factory :second_task, class: Task do
    task_name { 'test_task2' }
    details { 'test_content2' }
    deadline { '2022-07-23' }
    status { '着手中' }
    priority { '中' }
    # association :user, factory: :
    after(:build) do |second_task|
      second_label = create(:second_label)
      second_task.label_links << build(:label_link, task: second_task, label: second_label )
    end

  end

  factory :third_task, class: Task do
    task_name { 'test_task3' }
    details { 'test_content3' }
    deadline { '2023-08-24' }
    status { '未着手' }
    priority { '低' }
    # association :user
    after(:build) do |third_task|
      second_label = create(:third_label)
      third_task.label_links << build(:label_link, task: third_task, label: third_label )
    end
  end

end