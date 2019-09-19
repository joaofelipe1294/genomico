class AddEdtaSampleKind < ActiveRecord::Migration[5.2]
  def change
    SampleKind.create({
      name: 'Plasma em EDTA',
      acronym: 'EDTA',
      refference_index: 0
    })
  end
end
