module DataGenerator

  def generate_users
  	user_kind = UserKind.create({name: 'user'})
  	User.create([
  		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name},
  		{login: Faker::Internet.username, password: '1234', user_kind: user_kind, name: Faker::Name.name}
  	])
  end

end
