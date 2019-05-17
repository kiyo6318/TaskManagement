status = ["未着手","着手中","完了"]
100.times do |index|
  Task.create(title:"タイトル#{index}",content:"本文#{index}",deadline:Time.current + index.days,status:status[rand(3)],priority:rand(3))
end
