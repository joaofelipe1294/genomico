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

#############################################################

# puts "Cirando OfferedExams ..."

#IMUNOFENO
# OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE NEOPLASIAS HEMATOLÓGICAS', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE NEOPLASIAS HEMATOLÓGICAS', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS NK (CD3-/CD16+/CD56+)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS B (CD19+)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T - TOTAL (CD3+)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T HELPER (CD3+/CD4+)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD4/CD8', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD20+', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD2+', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T  (CD3+) E B (CD19+)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'IMUNOFENOTIPAGEM  PÓS TMO RECUPERAÇÃO IMUNE', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD1a', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD2', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD3', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD3 CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD4', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD5', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD7', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD8', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD9', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD10', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD11b', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD13', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD14', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD15', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD16', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD19', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD20', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD21', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD22', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD33', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD34', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD35', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD36', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD38', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD45', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD45RA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD45RO', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD56', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD58', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD64', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD66c', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD71', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD79a CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD81', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD99', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD117', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR CD123', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR HLA-DR', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR IGM', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR IGM CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR IREM2', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR KAPPA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR KAPPA CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR LAMBDA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR LAMBDA CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR MPO CITOPLASMA', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR NG2', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR TCRAB', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR TCRGD', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR TDT NUCLEAR', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# # OfferedExam.create({name: 'MARCADOR 7AAD (VIABILIDADE)', is_active: true, field: Field.find_by_name('Imunofenotipagem'), refference_date: 5, group: :imunofeno})
# #OfferedExam.create({name: '', is_active: true, field: Field.find_by_name('Imunofenotipagem')})
#
# #ANATOMIA
# OfferedExam.create({name: 'ANÁTOMO PATOLÓGICO ONCO', is_active: true, field: Field.find_by_name('Anatomia Patológica'), refference_date: 10})
# # OfferedExam.create({name: 'IMUNOHISTOQUÍMICA ONCO', is_active: true, field: Field.find_by_name('Anatomia Patológica'), refference_date: 15})
#
# #FISH
# OfferedExam.create({name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LLA POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA FUSÃO BCR-ABL1 POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA QUEBRA DO GENE KMT2A (MLL) POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA FUSÃO ETV6-RUNX1 (TEL-AML1) POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA QUEBRA DO GENE CBFB POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA FUSÃO PML-RARA POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA FUSÃO RUNX1/RUNX1T1 (AML1-ETO) POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 4 POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 10 POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 17 POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA AMPLIFICAÇÃO DO GENE N-MYC POR FISH (NEUROBLASTOMA)', is_active: true, field: Field.find_by_name('FISH'), refference_date: 30, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA DELEÇÃO 1P POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PESQUISA DA DELEÇÃO 19Q POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# # OfferedExam.create({name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LMA POR FISH', is_active: true, field: Field.find_by_name('FISH'), refference_date: 20, group: :fish})
# #OfferedExam.create({name: '', is_active: true, field: Field.find_by_name('FISH')})
#
# #BIOMOL
# OfferedExam.create({name: 'PESQUISA DO REARRANJO BCR-ABL1 (P190) POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P190 POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P210 POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR1 POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR2 POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR3 POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'EXOMA ONCOLOGIA', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 90, group: :ngs})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE FLT3 - PESQUISA DA MUTAÇÃO D835', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE FLT3 - ITD', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE NPM1 - INDEL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE CEBPA', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER REARRANJO BCR-ABL1 - PESQUISA DE MUTAÇÃO TKD', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'PAINEL DE ALTERAÇÕES EM LLA POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO BCR-ABL1 P210 POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO ETV6-RUNX1 (TEL-AML1) POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO KMT2A/AFF1 (MLL-AF4) POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO TCF3-PBX1 (E2A-PBX1) POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PAINEL DE ALTERAÇÕES EM LMA POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO PML-RARA POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO RUNX1/RUNX1T1 (AML1-ETO) POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO CBFB-MYH11 POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PESQUISA DO REARRANJO SIL-TAL1 POR PCR', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'QUANTIFICAÇÃO DO CITOMEGALOVÍRUS POR PCR EM TEMPO REAL', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 12, group: :pcr})
# # OfferedExam.create({name: 'PAINEL REARRANJOS LEUCEMIA POR NGS', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :ngs})
# # OfferedExam.create({name: 'PAINEL DOENÇA RESIDUAL MÍNIMA POR NGS', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :ngs})
# # OfferedExam.create({name: 'PAINEL DE NEOPLASIAS INFANTIS POR NGS', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :ngs})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE KIT - EXONS 8-11 E 17', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE KIT - PESQUISA DA MUTAÇÃO D816V', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'SEQUENCIAMENTO SANGER GENE BRAF - PESQUISA DA MUTAÇÃO V600E', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20, group: :sequencing})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-A EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-B EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-C EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DRB1 EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DQB1 EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DPB1 EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM ALTA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-A EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-B EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-C EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DRB1 EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DQB1 EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGEM DO GENE HLA-DPB1 EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# # OfferedExam.create({name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM MÉDIA RESOLUÇÃO', is_active: true, field: Field.find_by_name('Biologia Molecular'), refference_date: 20})
# #OfferedExam.create({name: '', is_active: true, field: Field.find_by_name('Biologia Molecular')})
#
# #CITOGENETICA
# OfferedExam.create({name: 'CARIÓTIPO DE MEDULA ÓSSEA COM BANDEAMENTO G ONCO', is_active: true, field: Field.find_by_name('Citogenética'), refference_date: 20})
# # OfferedExam.create({name: 'CARIÓTIPO DE SANGUE PERIFÉRICO PARA DIAGNÓSTICO DE NEOPLASIAS', is_active: true, field: Field.find_by_name('Citogenética'), refference_date: 30})

# puts "Criando OfferedExams [OK]"

#############################################################

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
