class AddReferenceBetweenOfferedExamsAndOfferedExamGroups < ActiveRecord::Migration[5.2]
  def change
    #add_reference :offered_exams, :offered_exam_group, foreign_key: true, index: true

    #OfferedExamGroup.create([
    #  { name: "Imunofenotipagem" },
    #  { name: "FISH" },
    #  { name: "NGS" },
    #  { name: "PCR e qPCR"},
    #  { name: "Sequenciamento"}
    #])

    #OfferedExam.where(field: Field.IMUNOFENO).each do |exam|
    #  exam.update(offered_exam_group: OfferedExamGroup.find_by(name: "Imunofenotipagem"))
    #end

    #OfferedExam.where(field: Field.FISH).each do |exam|
    #  exam.update(offered_exam_group: OfferedExamGroup.find_by(name: "FISH"))
    #end

    #OfferedExam.find_by(name: "PAINEL DE NEOPLASIAS INFANTIS POR NGS").update(offered_exam_group: OfferedExamGroup.find_by(name: "NGS"))
    #OfferedExam.find_by(name: "EXOMA ONCOLOGIA").update(offered_exam_group: OfferedExamGroup.find_by(name: "NGS"))

    #OfferedExam.where("name ILIKE '%PCR%'").each do |exam|
    #  exam.update(offered_exam_group: OfferedExamGroup.find_by(name: "PCR e qPCR"))
    #end

    #OfferedExam.where("name ILIKE '%Sequenciamento%'").each do |exam|
    #  exam.update(offered_exam_group: OfferedExamGroup.find_by(name: "Sequenciamento"))
    #end

  end
end
