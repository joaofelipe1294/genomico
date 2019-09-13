class AddTableInternalCodesWorkMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :internal_codes_work_maps do |t|
    	t.belongs_to :internal_code, index: true
      t.belongs_to :work_map, index: true
    end
  end
end
