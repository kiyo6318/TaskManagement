FactoryBot.define do

  factory :task do
    title {"タイトル1"}
    content {"本文1"}
    deadline {"2020-03-01"}
    created_at {Time.current + 1.days}
  end

  factory :second_task,class: Task do
    title {"タイトル2"}
    content {"本文2"}
    deadline {"2020-02-01"}
    created_at {Time.current + 2.days}
  end

  factory :third_task,class: Task do
    title {"タイトル3"}
    content {"本文3"}
    deadline {"2020-01-01"}
    created_at {Time.current + 3.days}
  end
end