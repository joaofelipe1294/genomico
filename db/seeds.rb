puts 'Criando Tipos de usuário ...'

UserKind.create([
	{name: 'user'},
	{name: 'admin'}
])

puts 'Criando Tipos de usuário [OK]'

############################################################

puts 'Criando Admin para teste ...'

User.create({
	login: 'admin',
	password: '1234',
	name: 'root',
	user_kind: UserKind.find_by({name: 'admin'})
})

puts 'Criando Admin para teste [OK]'

############################################################

puts 'Criando Fields ...'

Field.create([
	{name: 'Citogenética'},
	{name: 'FISH'},
	{name: 'Biologia Molecular'},
	{name: 'Anatomia Patológica'},
	{name: 'Imunofenotipagem'},
])

puts 'Criando Fields [OK]'

############################################################