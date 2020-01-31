module UserLogin

  def imunofeno_user_do_login
  	field = Field.IMUNOFENO if field.nil?
  	@user = User.create({
  		login: Faker::Internet.username,
  		password: Faker::Internet.password,
  		name: Faker::Name.name,
  		is_active: true,
  		fields: [field],
  		kind: :user
  	})
  	login
  end

  def biomol_user_do_login
  	field = Field.BIOMOL if field.nil?
  	@user = User.create({
  		login: Faker::Internet.username,
  		password: Faker::Internet.password,
  		name: Faker::Name.name,
  		is_active: true,
  		fields: [field],
  		kind: :user
  	})
  	login
  end

  def login
  	visit root_path
  	fill_in "login", with: @user.login
  	fill_in "password", with: @user.password
  	click_button id: 'btn-login'
  end

  def admin_do_login
  	@user = User.create({
  		login: 'admin',
  		name: 'root',
  		password: '1234',
  		kind: :admin
  	})
  	login
  end

end
