# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# .envに記載
admins = [
  {email: ENV["SECRET_EMAIL"], password: ENV["SECRET_PASSWORD"]}
]
# 管理者のデータがない場合のみ作成
admins.each do |admin|
  admin_email = Admin.find_by(email: admin[:email])
  if admin_email.nil?
    Admin.create!(
      email:    admin[:email],
      password: admin[:password]
    )
  end
end

# Meatのテストデータ
meats = [
  {id: 1, meat_type: "牛", head_weight: 300000, meat_profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/meats/牛アイコン.jpeg"), filename: "牛アイコン.jpeg")},
  {id: 2, meat_type: "豚", head_weight: 60000,  meat_profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/meats/豚アイコン.jpeg"), filename: "豚アイコン.jpeg")},
  {id: 3, meat_type: "鶏", head_weight: 1200,   meat_profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/meats/鶏アイコン.jpeg"), filename: "鶏アイコン.jpeg")},
  {id: 4, meat_type: "羊", head_weight: 50000,  meat_profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/meats/羊アイコン.jpeg"), filename: "羊アイコン.jpeg")},
  {id: 5, meat_type: "馬", head_weight: 400000, meat_profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/meats/馬アイコン.jpeg"), filename: "馬アイコン.jpeg")}
]
# Meatのデータがない場合のみ作成(meat_typeは一意性)
meats.each do |meat|
  meat_meat_type = Meat.find_by(meat_type: meat[:meat_type])
  if meat_meat_type.nil?
    Meat.create!(

      meat_type:          meat[:meat_type],
      head_weight:        meat[:head_weight],
      meat_profile_image: meat[:meat_profile_image]
    )
  end
end

# ユーザーテストデータ
users = [
  {id: 1, nick_name: "山田です。", email: "user1@example.com", password: "passw@rd", phone_number: "0000000001", is_active: true,  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/sample-author1.jpg"), filename: "sample-author1.jpg")},
  {id: 2, nick_name: "鈴木です。", email: "user2@example.com", password: "passw@rd", phone_number: "0000000002", is_active: true,  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/sample-author2.jpg"), filename: "sample-author2.jpg")},
  {id: 3, nick_name: "佐藤です。", email: "user3@example.com", password: "passw@rd", phone_number: "0000000003", is_active: true,  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/sample-author3.jpg"), filename: "sample-author3.jpg")},
  {id: 4, nick_name: "斉藤ママ",   email: "user4@example.com", password: "passw@rd", phone_number: "0000000004", is_active: true,  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/sample-author4.jpg"), filename: "sample-author4.jpg")},
  {id: 5, nick_name: "相田ママ",   email: "user5@example.com", password: "passw@rd", phone_number: "0000000005", is_active: true,  profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/sample-author5.jpg"), filename: "sample-author5.jpg")},
  {id: 6, nick_name: "ユーザー",   email: "user6@example.com", password: "passw@rd", phone_number: "0000000006", is_active: false, profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/users/default-image.jpeg"), filename: "default-image.jpeg")}
]
# Userのデータがない場合のみ作成(nick_nameは一意性)
users.each do |user|
  user_nick_name = User.find_by(nick_name: user[:nick_name])
  if user_nick_name.nil?
    User.create!(
       nick_name:     user[:nick_name],
       email:         user[:email],
       password:      user[:password],
       phone_number:  user[:phone_number],
       is_active:     user[:is_active],
       profile_image: user[:profile_image]
    )
  end
end

# Tweetのテストデータ
tweets = [
  {id: 1,  user_id: 1, meat_id: 1, body: "今日は焼肉でーす。",           once_weight: 500,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},
  {id: 2,  user_id: 1, meat_id: 1, body: "今日も焼肉でーす。",           once_weight: 600,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},
  {id: 3,  user_id: 1, meat_id: 5, body: "初めての馬肉",                 once_weight: 100,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/馬肉（外）.jpg"), filename: "sample-author1.馬肉（外）.jpg")},
  {id: 4,  user_id: 2, meat_id: 2, body: "今日は豚肉食べやす",           once_weight: 300,  on_display: true,  is_active: false, meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/豚肉（外）.jpg"), filename: "sample-author1.豚肉（外）.jpg")},
  {id: 5,  user_id: 2, meat_id: 3, body: "母ちゃんの唐揚げ",             once_weight: 900,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/鶏肉（外）.jpg"), filename: "sample-author1.鶏肉（外）.jpg")},
  {id: 6,  user_id: 3, meat_id: 4, body: "ラムチョップ好き。",           once_weight: 700,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/羊肉（外）.jpg"), filename: "sample-author1.羊肉（外）.jpg")},
  {id: 7,  user_id: 3, meat_id: 4, body: "ラムチョップ好き。",           once_weight: 700,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/羊肉（外）.jpg"), filename: "sample-author1.羊肉（外）.jpg")},
  {id: 8,  user_id: 3, meat_id: 4, body: "ラムチョップ好き。",           once_weight: 700,  on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/羊肉（外）.jpg"), filename: "sample-author1.羊肉（外）.jpg")},
  {id: 9,  user_id: 4, meat_id: 1, body: "今日は牛肉で沢山料理します。", once_weight: 3000, on_display: false, is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（内）.jpg"), filename: "sample-author1.牛肉（内）.jpg")},
  {id: 10, user_id: 4, meat_id: 2, body: "今日は豚肉で沢山料理します。", once_weight: 3000, on_display: false, is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/豚肉（内）.jpg"), filename: "sample-author1.豚肉（内）.jpg")},
  {id: 11, user_id: 4, meat_id: 3, body: "今日は鶏肉で沢山料理します。", once_weight: 3000, on_display: false, is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/鶏肉（内）.jpg"), filename: "sample-author1.鶏肉（内）.jpg")},
  {id: 12, user_id: 4, meat_id: 4, body: "今日は羊肉で沢山料理します。", once_weight: 4000, on_display: false, is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/羊肉（内）.jpg"), filename: "sample-author1.羊肉（内）.jpg")},
  {id: 13, user_id: 4, meat_id: 5, body: "今日は馬刺しです。",           once_weight: 2000, on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/馬肉（内）.jpg"), filename: "sample-author1.馬肉（内）.jpg")},
  {id: 14, user_id: 5, meat_id: 1, body: "牛肉祭り",                     once_weight: 5000, on_display: true,  is_active: false, meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},
  {id: 15, user_id: 5, meat_id: 1, body: "牛肉祭り",                     once_weight: 5000, on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},
  {id: 16, user_id: 6, meat_id: 1, body: "牛肉食べました。",             once_weight: 5000, on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},
  {id: 17, user_id: 6, meat_id: 1, body: "牛肉食べました。",             once_weight: 5000, on_display: true,  is_active: true,  meat_image:ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/tweets/牛肉（外）.jpg"), filename: "sample-author1.牛肉（外）.jpg")},

]
# Tweetのデータがない場合のみ作成
tweets.each do |tweet|
  tweet_id = Tweet.find_by(id: tweet[:id])
  if tweet_id.nil?
    Tweet.create!(
       user_id:     tweet[:user_id],
       meat_id:     tweet[:meat_id],
       body:        tweet[:body],
       once_weight: tweet[:once_weight],
       on_display:  tweet[:on_display],
       is_active:   tweet[:is_active],
       meat_image:  tweet[:meat_image]
    )
  end
end




