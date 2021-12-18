User.create!(
  name: '管理者',
  nickname: 'マネージャー',
  email: 'manager@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

99.times do |n|
  name  = Gimei.name
  nickname = Gimei.name
  email = "sample-#{n+1}@example.com"
  password = "foobar"
  User.create!(name:  name,
               nickname: nickname,
               email: email,
               password:              password,
               password_confirmation: password)
end

50.times do |n|
  Question.create!(title: "質問タイトル#{n}",
                   content: "質問サンプル#{n}",
                   user_id: User.find(n+1).id,
                   solved_check: [false, true].sample)
end

48.times do |n|
  Answer.create!(question_id: Question.find(n+2).id,
                 user_id: User.find(n+2).id,
                 content: "回答#{n}")
end
