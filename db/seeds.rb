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

puts 'Criando AttendanceStatusKinds ...'

AttendanceStatusKind.create({name: 'Em andamento'})
AttendanceStatusKind.create({name: 'Liberado técnico'})
AttendanceStatusKind.create({name: 'Em repetição'})
AttendanceStatusKind.create({name: 'Assinado'})

puts 'Criando AttendanceStatusKinds [OK]'

############################################################

puts 'Criando HealthEnsurances ...'

HealthEnsurance.create({name: 'BRADESCO'})
HealthEnsurance.create({name: 'HOSPITAL PEQUENO PRINCIPE'})
HealthEnsurance.create({name: 'INSTITUTO PELÉ PEQUENO PRÍNCIPE'})
HealthEnsurance.create({name: 'SESMT'})
HealthEnsurance.create({name: 'LABORATORIO EXAMINARE - STA BRÍGIDA'})
HealthEnsurance.create({name: 'ALLIANZ SAUDE'})
HealthEnsurance.create({name: 'AMIL'})
HealthEnsurance.create({name: 'AMIL DIX CLASSIC'})
HealthEnsurance.create({name: 'BANCO DO BRASIL CASSI'})
HealthEnsurance.create({name: 'CAIXA ECONOMICA FEDERAL'})
HealthEnsurance.create({name: 'CARE PLUS'})
HealthEnsurance.create({name: 'CENTAURO SEGURADORA'})
HealthEnsurance.create({name: 'CLINICA ADVENTISTA DE CURITIBA'})
HealthEnsurance.create({name: 'CLINIPAM'})
HealthEnsurance.create({name: 'COAMO - FUPS'})
HealthEnsurance.create({name: 'COLEGIO BOM JESUS'})
HealthEnsurance.create({name: 'COPEL'})
HealthEnsurance.create({name: 'CORITIBA FOOT BALL CLUB'})
HealthEnsurance.create({name: 'C.S ASSISTANCE'})
HealthEnsurance.create({name: 'ELETROSUL'})
HealthEnsurance.create({name: 'ESTADO DO MATO GROSSO'})
HealthEnsurance.create({name: 'FASSINCRA'})
HealthEnsurance.create({name: 'FUNDACAO SANEPAR'})
HealthEnsurance.create({name: 'FUNDACAO SAUDE ITAU'})
HealthEnsurance.create({name: 'FUNDO DO ESTADO DE CANOINHAS'})
HealthEnsurance.create({name: 'FUNDO EST DE SAUDE DO PR FUNSA'})
HealthEnsurance.create({name: 'FUNDO EST DE SAUDE MATO GROSSO'})
HealthEnsurance.create({name: 'FUNDO EST DE SAUDE P. EST PARA'})
HealthEnsurance.create({name: 'FUNDO EST DE SAUDE RONDONIA'})
HealthEnsurance.create({name: 'FUNDO EST DE SAUDE FLORIANOPOLIS'})
HealthEnsurance.create({name: 'FUNDO MUNI DE SAUDE DE IBIRAMA'})
HealthEnsurance.create({name: 'FUNSEP'})
HealthEnsurance.create({name: 'FUSEX'})
HealthEnsurance.create({name: 'GAMA SAUDE'})
HealthEnsurance.create({name: 'GEAP'})
HealthEnsurance.create({name: 'GMC DO BRASIL'})
HealthEnsurance.create({name: 'ICS'})
HealthEnsurance.create({name: 'IMASP - INST.MUNIC. DE ASSIST'})
HealthEnsurance.create({name: 'ITAIPU BINACIONAL'})
HealthEnsurance.create({name: 'MEDISERVICE'})
HealthEnsurance.create({name: 'NOSSA SAUDE'})
HealthEnsurance.create({name: 'NOTRE DAME'})
HealthEnsurance.create({name: 'PARANA CLINICAS'})
HealthEnsurance.create({name: 'PARTICULAR'})
HealthEnsurance.create({name: 'PESQUISA CLINICA LABORAT. HPP'})
HealthEnsurance.create({name: 'PETROBRAS DISTRIBUIDORA - BR'})
HealthEnsurance.create({name: 'PETROBRAS PETROLEO'})
HealthEnsurance.create({name: 'PLASSMA'})
HealthEnsurance.create({name: 'PRO SAUDE UEPG'})
HealthEnsurance.create({name: 'PROASA'})
HealthEnsurance.create({name: 'SANTA CASA DE MARINGA'})
HealthEnsurance.create({name: 'SAUDE IDEAL'})
HealthEnsurance.create({name: 'SECRETARIA MUNICIPAL DE SAUDE'})
HealthEnsurance.create({name: 'SINDESTIVA'})
HealthEnsurance.create({name: 'SUL AMERICA SAUDE'})
HealthEnsurance.create({name: 'SUS - AMBULATÓRIO'})
HealthEnsurance.create({name: 'SUS - INTERNAÇÃO'})
HealthEnsurance.create({name: 'TEMPO SAUDE'})
HealthEnsurance.create({name: 'UNIMED CURITIBA'})
HealthEnsurance.create({name: 'UNIMED INTERCAMBIO'})
HealthEnsurance.create({name: 'VACINI'})
HealthEnsurance.create({name: 'VOLVO DO BRASIL - VOAM'})
HealthEnsurance.create({name: 'WAL-MART BRASIL'})
HealthEnsurance.create({name: 'VOLKSWAGEN'})
HealthEnsurance.create({name: 'HOSPITAL ERASTO GAERTNER'})
HealthEnsurance.create({name: 'CINDACTA'})
HealthEnsurance.create({name: 'HNSG'})
HealthEnsurance.create({name: 'PORTARIA GM/MS 199'})
HealthEnsurance.create({name: 'UOPECCAN'})

puts 'Criando HealthEnsurances [OK]'

############################################################

puts 'Criando DeseaseStage ...'

DeseaseStage.create({name: 'Diagnóstico'})
DeseaseStage.create({name: 'Recaída'})
DeseaseStage.create({name: 'DRM'})

puts 'Criando DeseaseStage [OK]'

























