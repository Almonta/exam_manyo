FactoryBot.define do
  factory :label do
    name { "test_label1" }
  end

  factory :second_label, class: Label do
    name { "test_label2" }
  end

  factory :third_label, class: Label do
    name { "test_label3" }
  end

end
