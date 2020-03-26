class RemoveTimeForseen < ActiveRecord::Migration[5.2]
  def change
    remove_column :suggestions, :time_forseen
  end
end
