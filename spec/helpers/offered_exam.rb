def setup_offered_exam
	Field.create([{name: 'Biomol'}, {name: 'Imunofeno'}, {name: 'Anatomia'}])
	OfferedExam.create([
		{name: 'Primeiro Exame', field: Field.order(name: :desc).first},
		{name: 'Algum exame complicado', field: Field.order(name: :desc).first},
		{name: 'Exame bem simples', field: Field.order(name: :desc).last}
	])
end