UserKind.create([
	{name: 'user'},
	{name: 'admin'}
])

User.create({
	login: 'admin',
	password: '1234',
	name: 'root',
	user_kind: UserKind.find_by({name: 'admin'})
})

Field.create([
	{name: 'Citogenética'},
	{name: 'FISH'},
	{name: 'Biologia Molecular'},
	{name: 'Anatomia Patológica'},
	{name: 'Imunofenotipagem'},
])