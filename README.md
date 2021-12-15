# README


----
* seed.rb

Admin.create!(
  email: "nagano_CAKE@gmail.com",
  password: "7gan0-CAKE"
  )
 
 Member.create!(
  last_name: "test",
  first_name: "aki",
  last_name_kana: "てすと",
  first_name_kana: "あき",
  postal_code: "1234567",
  address: "長野県カフェ市",
  telephone_number: "01234567890",
  email: "test-aki@test.com",
  password: "111111",
  )
  
    50.times do |n|
    Member.create!(
      last_name: "テスト#{n + 1}号",
      first_name: "太郎",
      last_name_kana: "テスト",
      first_name_kana: "タロウ",
      postal_code: "1234567",
      address: "長野県カフェ市#{n + 1}区",
      telephone_number: "01234567890",
      email: "tester#{n + 1}@test.com",
      password: "111111",
    )
  end
  <!--50人のサンプルデータ作成します-->
  
Genre.create!(
    name: "ケーキ"
)
Product.create!(
    genre_id: 1,
    name: "ショートケーキ",
    introduction: "ショートケーキだよ",
    price: 298,
    is_active: true
)
Product.create!(
    genre_id: 2,
    name: "チョコケーキ",
    introduction: "チョコレートケーキだよ",
    price: 398,
    is_active: true
)

CartProduct.create!(
    member_id: 1,
    product_id: 1,
    quantity: 2
)
CartProduct.create!(
    member_id: 1,
    product_id: 2,
    quantity: 3
)



----

-----

