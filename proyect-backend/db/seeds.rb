10.times do
    Employee.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      username: Faker::Internet.user_name,
      password: Faker::Internet.password,
      email: Faker::Internet.email,
      encrypted_password: Devise.friendly_token,
      role: Faker::Number.between(from: 1, to: 3)
      
    )
  end

  10.times do
    Product.create(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.sentence,
      price: Faker::Commerce.price(range: 1.00..1000.00),
      category: Faker::Number.between(from: 1, to: 5),
      image: Faker::Lorem.sentence
    )
  end

  10.times do
    Table.create(
        status: Faker::Number.between(from: 1, to: 2),
        capacity: Faker::Number.between(from: 1, to: 6)
    )
  end
