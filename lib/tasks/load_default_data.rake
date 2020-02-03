namespace :load_default_data do
  desc "create all health ensurances used"
  task health_ensurances: :environment do
    HealthEnsurance.create([
      { name: 'BRADESCO' },
      { name: 'HOSPITAL PEQUENO PRINCIPE' },
      { name: 'INSTITUTO PELÉ PEQUENO PRÍNCIPE' },
      { name: 'SESMT' },
      { name: 'LABORATORIO EXAMINARE - STA BRÍGIDA' },
      { name: 'ALLIANZ SAUDE' },
      { name: 'AMIL' },
      { name: 'AMIL DIX CLASSIC' },
      { name: 'BANCO DO BRASIL CASSI' },
      { name: 'CAIXA ECONOMICA FEDERAL' },
      { name: 'CARE PLUS' },
      { name: 'CENTAURO SEGURADORA' },
      { name: 'CLINICA ADVENTISTA DE CURITIBA' },
      { name: 'CLINIPAM' },
      { name: 'COAMO - FUPS' },
      { name: 'COLEGIO BOM JESUS' },
      { name: 'COPEL' },
      { name: 'CORITIBA FOOT BALL CLUB' },
      { name: 'C.S ASSISTANCE' },
      { name: 'ELETROSUL' },
      { name: 'ESTADO DO MATO GROSSO' },
      { name: 'FASSINCRA' },
      { name: 'FUNDACAO SANEPAR' },
      { name: 'FUNDACAO SAUDE ITAU' },
      { name: 'FUNDO DO ESTADO DE CANOINHAS' },
      { name: 'FUNDO EST DE SAUDE DO PR FUNSA' },
      { name: 'FUNDO EST DE SAUDE MATO GROSSO' },
      { name: 'FUNDO EST DE SAUDE P. EST PARA' },
      { name: 'FUNDO EST DE SAUDE RONDONIA' },
      { name: 'FUNDO EST DE SAUDE FLORIANOPOLIS' },
      { name: 'FUNDO MUNI DE SAUDE DE IBIRAMA' },
      { name: 'FUNSEP' },
      { name: 'FUSEX' },
      { name: 'GAMA SAUDE' },
      { name: 'GEAP' },
      { name: 'GMC DO BRASIL' },
      { name: 'ICS' },
      { name: 'IMASP - INST.MUNIC. DE ASSIST' },
      { name: 'ITAIPU BINACIONAL' },
      { name: 'MEDISERVICE' },
      { name: 'NOSSA SAUDE' },
      { name: 'NOTRE DAME' },
      { name: 'PARANA CLINICAS' },
      { name: 'PARTICULAR' },
      { name: 'PESQUISA CLINICA LABORAT. HPP' },
      { name: 'PETROBRAS DISTRIBUIDORA - BR' },
      { name: 'PETROBRAS PETROLEO' },
      { name: 'PLASSMA' },
      { name: 'PRO SAUDE UEPG' },
      { name: 'PROASA' },
      { name: 'SANTA CASA DE MARINGA' },
      { name: 'SAUDE IDEAL' },
      { name: 'SECRETARIA MUNICIPAL DE SAUDE' },
      { name: 'SINDESTIVA' },
      { name: 'SUL AMERICA SAUDE' },
      { name: 'SUS - AMBULATÓRIO' },
      { name: 'SUS - INTERNAÇÃO' },
      { name: 'TEMPO SAUDE' },
      { name: 'UNIMED CURITIBA' },
      { name: 'UNIMED INTERCAMBIO' },
      { name: 'VACINI' },
      { name: 'VOLVO DO BRASIL - VOAM' },
      { name: 'WAL-MART BRASIL' },
      { name: 'VOLKSWAGEN' },
      { name: 'HOSPITAL ERASTO GAERTNER' },
      { name: 'CINDACTA' },
      { name: 'HNSG' },
      { name: 'PORTARIA GM/MS 199' },
      { name: 'UOPECCAN' },
    ])
  end

  desc "Cadastra lista com os exames realizados pelo laboratório"
  task offered_exams: :environment do
    OfferedExam.create([
      {name: 'IMUNOFENOTIPAGEM DE NEOPLASIAS HEMATOLÓGICAS', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE NEOPLASIAS HEMATOLÓGICAS', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS NK (CD3-/CD16+/CD56+)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS B (CD19+)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T - TOTAL (CD3+)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T HELPER (CD3+/CD4+)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD4/CD8', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD20+', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS CD2+', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM DE LINFÓCITOS T  (CD3+) E B (CD19+)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'IMUNOFENOTIPAGEM  PÓS TMO RECUPERAÇÃO IMUNE', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD1a', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD2', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD3', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD3 CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD4', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD5', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD7', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD8', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD9', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD10', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD11b', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD13', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD14', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD15', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD16', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD19', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD20', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD21', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD22', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD33', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD34', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD35', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD36', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD38', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD45', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD45RA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD45RO', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD56', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD58', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD64', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD66c', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD71', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD79a CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD81', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD99', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD117', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR CD123', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR HLA-DR', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR IGM', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR IGM CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR IREM2', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR KAPPA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR KAPPA CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR LAMBDA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR LAMBDA CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR MPO CITOPLASMA', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR NG2', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR TCRAB', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR TCRGD', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR TDT NUCLEAR', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
      {name: 'MARCADOR 7AAD (VIABILIDADE)', field: Field.IMUNOFENO, refference_date: 5, group: :imunofeno},
    ])

    #ANATOMIA
    # OfferedExam.create({name: 'ANÁTOMO PATOLÓGICO ONCO', field: Field.find_by_name('Anatomia Patológica'), refference_date: 10, group: :anatomy})
    # OfferedExam.create({name: 'IMUNOHISTOQUÍMICA ONCO', field: Field.find_by_name('Anatomia Patológica'), refference_date: 15, group: :anatomy})

    #FISH
    OfferedExam.create([
      {name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LLA POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA FUSÃO BCR-ABL1 POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA QUEBRA DO GENE KMT2A (MLL) POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA FUSÃO ETV6-RUNX1 (TEL-AML1) POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA QUEBRA DO GENE CBFB POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA FUSÃO PML-RARA POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA FUSÃO RUNX1/RUNX1T1 (AML1-ETO) POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 4 POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 10 POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 17 POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA AMPLIFICAÇÃO DO GENE N-MYC POR FISH (NEUROBLASTOMA)', refference_date: 30, group: :fish},
      {name: 'PESQUISA DA DELEÇÃO 1P POR FISH', refference_date: 20, group: :fish},
      {name: 'PESQUISA DA DELEÇÃO 19Q POR FISH', refference_date: 20, group: :fish},
      {name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LMA POR FISH', refference_date: 20, group: :fish},
    ])

    #BIOMOL
    OfferedExam.create([
      {name: 'PESQUISA DO REARRANJO BCR-ABL1 (P190) POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P190 POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P210 POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR1 POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR2 POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR3 POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'EXOMA ONCOLOGIA', field: Field.BIOMOL, refference_date: 90, group: :ngs},
      {name: 'SEQUENCIAMENTO SANGER GENE FLT3 - PESQUISA DA MUTAÇÃO D835', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER GENE FLT3 - ITD', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER GENE NPM1 - INDEL', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER GENE CEBPA', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER REARRANJO BCR-ABL1 - PESQUISA DE MUTAÇÃO TKD', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'PAINEL DE ALTERAÇÕES EM LLA POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO BCR-ABL1 P210 POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO ETV6-RUNX1 (TEL-AML1) POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO KMT2A/AFF1 (MLL-AF4) POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO TCF3-PBX1 (E2A-PBX1) POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PAINEL DE ALTERAÇÕES EM LMA POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO PML-RARA POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO RUNX1/RUNX1T1 (AML1-ETO) POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO CBFB-MYH11 POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PESQUISA DO REARRANJO SIL-TAL1 POR PCR', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'QUANTIFICAÇÃO DO CITOMEGALOVÍRUS POR PCR EM TEMPO REAL', field: Field.BIOMOL, refference_date: 12, group: :pcr},
      {name: 'PAINEL REARRANJOS LEUCEMIA POR NGS', field: Field.BIOMOL, refference_date: 20, group: :ngs},
      {name: 'PAINEL DOENÇA RESIDUAL MÍNIMA POR NGS', field: Field.BIOMOL, refference_date: 20, group: :ngs},
      {name: 'PAINEL DE NEOPLASIAS INFANTIS POR NGS', field: Field.BIOMOL, refference_date: 20, group: :ngs},
      {name: 'SEQUENCIAMENTO SANGER GENE KIT - EXONS 8-11 E 17', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER GENE KIT - PESQUISA DA MUTAÇÃO D816V', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'SEQUENCIAMENTO SANGER GENE BRAF - PESQUISA DA MUTAÇÃO V600E', field: Field.BIOMOL, refference_date: 20, group: :sequencing},
      {name: 'TIPAGEM DO GENE HLA-A EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-B EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-C EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DRB1 EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DQB1 EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DPB1 EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM ALTA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-A EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-B EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-C EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DRB1 EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DQB1 EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGEM DO GENE HLA-DPB1 EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
      {name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM MÉDIA RESOLUÇÃO', field: Field.BIOMOL, refference_date: 20},
    ])

    #CITOGENETICA
    # OfferedExam.create({name: 'CARIÓTIPO DE MEDULA ÓSSEA COM BANDEAMENTO G ONCO', is_active: true, field: Field.find_by_name('Citogenética'), refference_date: 20})
    # # OfferedExam.create({name: 'CARIÓTIPO DE SANGUE PERIFÉRICO PARA DIAGNÓSTICO DE NEOPLASIAS', is_active: true, field: Field.find_by_name('Citogenética'), refference_date: 30})

  end

end
