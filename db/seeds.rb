#管理者ログイン
Admin.create!(
    email: 'test@hoge.com',
    password: 'testhoge',
 )

users = User.create!(
    [
      {email: 'tanaka@test.com', name: 'Tanaka', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
      {email: 'suzu@test.com', name: 'Suzu', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
      {email: 'akiko@test.com', name: 'Akiko', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
    ]
  )
  
Tag.create!(
    [
      {tag_name: '名作'}
    ]
  )

Post.create!(
    [
      {title: '羅生門', body: '芥川龍之介の羅生門を読んで、、、', image_book: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg"), user_id: users[0].id },
      {title: '檸檬', body: '梶井基次郎の檸檬を読んで、、、', image_book: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg"), user_id: users[1].id },
      {title: 'ノルウェイの森', body: '村上春樹のノルウェイの森を読んで、、、', user_id: users[2].id }
    ]
  )


PostTag.create!(
    [
        {post: Post.first, tag: Tag.first}
    ]
  )