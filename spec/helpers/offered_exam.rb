def setup_offered_exam
	Field.create([{name: 'Biomol'}, {name: 'Imunofeno'}, {name: 'Anatomia'}])
	OfferedExam.create([
		{name: 'Primeiro Exame', field: Field.order(name: :desc).first, refference_date: Faker::Number.number(digits: 2)},
		{name: 'Algum exame complicado', field: Field.order(name: :desc).first, refference_date: Faker::Number.number(digits: 2)},
		{name: 'Exame bem simples', field: Field.order(name: :desc).last, refference_date: Faker::Number.number(digits: 2)}
	])
end
