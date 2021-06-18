FactoryBot.define do
  factory :task do
    trait :a do
      id { 1 }
      task_name { 'manyo' }
      details { 'manyokadai' }
    end
    trait :b do
      id { 2 }
      task_name { 'monyo' }
      details { 'monyokadai' }
    end
    trait :c do
      id { 3 }
      task_name { 'nonyo' }
      details { 'nonyokadai' }
    end
  end
end