# puts 'Criando Fields ...'

Field.create([
	{name: 'Citogenética'},
	{name: 'FISH'},
	{name: 'Biologia Molecular'},
	{name: 'Anatomia Patológica'},
	{name: 'Imunofenotipagem'},
])

# puts 'Criando Fields [OK]'


# puts 'Criando HealthEnsurances [OK]'

#############################################################

# puts 'Criando ExamStatusKind ...'

ExamStatusKind.create([
	{name: 'Em andamento'},
	{name: 'Liberado técnico'},
	{name: 'Em repetição'},
	{name: 'Concluído'},
	{name: 'Aguardando início'},
	{name: 'Liberado parcial'},
	{name: 'Concluído (sem laudo)'},
	{name: 'Cancelado'},
])

# puts 'Criando ExamStatusKind [OK]'

#############################################################

# puts "Criando Sample_Kinds ..."

SampleKind.create([
	{name: 'Sangue periférico', acronym: 'SP', refference_index: 0},
	{name: 'Medula óssea', acronym: 'MO', refference_index: 0},
	{name: 'Liquor', acronym: 'LQ', refference_index: 0},
	{name: 'Biópsia de tecidos.', acronym: 'BT', refference_index: 0},
	{name: 'Swab bucal.', acronym: 'SB', refference_index: 0},
	{name: 'Bloco de parafina.', acronym: 'BP', refference_index: 0},
])

# puts 'Criando SubsampleKind ...'

SubsampleKind.create({name: 'RNA', acronym: 'RNA', refference_index: 1})
SubsampleKind.create({name: 'DNA', acronym: 'DNA', refference_index: 1})
SubsampleKind.create({name: 'Pellet de FISH', acronym: 'FISH', refference_index: 1})
SubsampleKind.create({name: 'DNA viral', acronym: 'CMV', refference_index: 1})

# puts 'Criando SubsampleKind [OK]'

#############################################################

# puts 'Criando Hospitals ...'

Hospital.create({name: 'Hospital Pequeno Príncipe'})


CurrentState.create([
	{name: "Estoque"},
	{name: "Em uso"},
	{name: "Concluído"}
	])
