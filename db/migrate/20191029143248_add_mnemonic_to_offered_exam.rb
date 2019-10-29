class AddMnemonicToOfferedExam < ActiveRecord::Migration[5.2]
  def change
    add_column :offered_exams, :mnemonyc, :string

    OfferedExam.find_by({name: 'IMUNOFENOTIPAGEM DE NEOPLASIAS HEMATOLÓGICAS'}).update(mnemonyc: "IMFNH")
    OfferedExam.find_by({name: 'Imunofenotipagem de Subpopulações Linfocitárias - (IMUSL)'}).update(mnemonyc: "IMUSL")
    OfferedExam.find_by({name: 'Imunofenotipagem de Perfil Imune Completo (IMUPI)'}).update(mnemonyc: "IMUPI")


    # #ANATOMIA
    OfferedExam.find_by({name: 'ANÁTOMO PATOLÓGICO ONCO'}).update(mnemonyc: "ANATPAT")
    OfferedExam.find_by({name: 'IMUNOHISTOQUÍMICA ONCO'}).update(mnemonyc: "IHQ")

    # #FISH
    OfferedExam.find_by({name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LLA POR FISH'}).update(mnemonyc: "FISHLLA")
    OfferedExam.find_by({name: 'PESQUISA DA FUSÃO BCR-ABL1 POR FISH'}).update(mnemonyc: "FISHBCR")
    OfferedExam.find_by({name: 'PESQUISA DA QUEBRA DO GENE KMT2A (MLL) POR FISH'}).update(mnemonyc: "FISHMT2A")
    OfferedExam.find_by({name: 'PESQUISA DA FUSÃO ETV6-RUNX1 (TEL-AML1) POR FISH'}).update(mnemonyc: "FISHETV6")
    OfferedExam.find_by({name: 'PESQUISA DA QUEBRA DO GENE CBFB POR FISH'}).update(mnemonyc: "FISHCBFB")
    OfferedExam.find_by({name: 'PESQUISA DA FUSÃO PML-RARA POR FISH'}).update(mnemonyc: "FISHPML")
    OfferedExam.find_by({name: 'PESQUISA DA FUSÃO RUNX1/RUNX1T1 (AML1-ETO) POR FISH'}).update(mnemonyc: "FISHRUNX1")
    OfferedExam.find_by({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 4 POR FISH'}).update(mnemonyc: "FISHC4")
    OfferedExam.find_by({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 10 POR FISH'}).update(mnemonyc: "FISHC10")
    OfferedExam.find_by({name: 'PESQUISA DE ALTERAÇÃO NUMÉRICA DO CROMOSSOMO 17 POR FISH'}).update(mnemonyc: "FISHC17")
    OfferedExam.find_by({name: 'PESQUISA DA AMPLIFICAÇÃO DO GENE N-MYC POR FISH (NEUROBLASTOMA)'}).update(mnemonyc: "FISHNMYC")
    OfferedExam.find_by({name: 'PESQUISA DA DELEÇÃO 1P POR FISH'}).update(mnemonyc: "FISH1P")
    OfferedExam.find_by({name: 'PESQUISA DA DELEÇÃO 19Q POR FISH'}).update(mnemonyc: "FISH19Q")
    OfferedExam.find_by({name: 'PAINEL DE ALTERAÇÕES CROMOSSÔMICAS EM LMA POR FISH'}).update(mnemonyc: "LMAFI")

    # #BIOMOL
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO BCR-ABL1 (P190) POR PCR'}).update(name: "QL190")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P190 POR PCR EM TEMPO REAL'}).update(name: "QT190")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO REARRANJO BCR-ABL1 P210 POR PCR EM TEMPO REAL'}).update(name: "QT210")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR1 POR PCR EM TEMPO REAL'}).update(name: "QTPML1")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR2 POR PCR EM TEMPO REAL'}).update(name: "QTPML2")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO REARRANJO PML-RARA BCR3 POR PCR EM TEMPO REAL'}).update(name: "QTPML3")
    OfferedExam.find_by({name: 'EXOMA ONCOLOGIA'}).update(name: "ONCOEX")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE FLT3 - PESQUISA DA MUTAÇÃO D835'}).update(name: "FLT3MUT")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE FLT3 - ITD'}).update(name: "FLTDITD")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE NPM1 - INDEL'}).update(name: "NPM1")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE CEBPA'}).update(name: "")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER REARRANJO BCR-ABL1 - PESQUISA DE MUTAÇÃO TKD'}).update(name: "BCRAB")
    OfferedExam.find_by({name: 'PAINEL DE ALTERAÇÕES EM LLA POR PCR'}).update(name: "")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO BCR-ABL1 P210 POR PCR'}).update(name: "QL210")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO ETV6-RUNX1 (TEL-AML1) POR PCR'}).update(name: "QLETV6")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO KMT2A/AFF1 (MLL-AF4) POR PCR'}).update(name: "QLKMT2A")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO TCF3-PBX1 (E2A-PBX1) POR PCR'}).update(name: "QLTCF3")
    OfferedExam.find_by({name: 'PAINEL DE ALTERAÇÕES EM LMA POR PCR'}).update(name: "PCRLMA")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO PML-RARA POR PCR'}).update(name: "QLPML")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO RUNX1/RUNX1T1 (AML1-ETO) POR PCR'}).update(name: "QLRUNX1")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO CBFB-MYH11 POR PCR'}).update(name: "QLCBFB")
    OfferedExam.find_by({name: 'PESQUISA DO REARRANJO SIL-TAL1 POR PCR'}).update(name: "")
    OfferedExam.find_by({name: 'QUANTIFICAÇÃO DO CITOMEGALOVÍRUS POR PCR EM TEMPO REAL'}).update(name: "")
    OfferedExam.find_by({name: 'PAINEL REARRANJOS LEUCEMIA POR NGS'}).update(name: "")
    OfferedExam.find_by({name: 'PAINEL DOENÇA RESIDUAL MÍNIMA POR NGS'}).update(name: "")
    OfferedExam.find_by({name: 'PAINEL DE NEOPLASIAS INFANTIS POR NGS'}).update(name: "NGSNEO")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE KIT - EXONS 8-11 E 17'}).update(name: "")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE KIT - PESQUISA DA MUTAÇÃO D816V'}).update(name: "KITD816V")
    OfferedExam.find_by({name: 'SEQUENCIAMENTO SANGER GENE BRAF - PESQUISA DA MUTAÇÃO V600E'}).update(name: "FV600E")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-A EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-B EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-C EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DRB1 EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DQB1 EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DPB1 EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM ALTA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-A EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-B EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-C EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DRB1 EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DQB1 EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGEM DO GENE HLA-DPB1 EM MÉDIA RESOLUÇÃO'}).update(name: "")
    OfferedExam.find_by({name: 'TIPAGENS DE GENES HLA DE CLASSE 1 E 2 EM MÉDIA RESOLUÇÃO'}).update(name: "")
    # #OfferedExam.find_by({name: '', is_active: true, field: Field.find_by_name('Biologia Molecular')})
    #
    # #CITOGENETICA
    OfferedExam.find_by({name: 'CARIÓTIPO DE MEDULA ÓSSEA COM BANDEAMENTO G ONCO'}).update(name: "GMOG")
    OfferedExam.find_by({name: 'CARIÓTIPO DE SANGUE PERIFÉRICO PARA DIAGNÓSTICO DE NEOPLASIAS'}).update(name: "CSPG")

  end
end
