class ChangeFieldBottlesNumberToReceiptNotice < ActiveRecord::Migration[5.2]
  def change
    add_column :samples, :receipt_notice, :text
    #Sample.find(3).delete
    #Sample.all.each do |sample|
    #  if sample.bottles_number == 1
    #    sample.receipt_notice = "1 frasco"
    #  else
    #    sample.receipt_notice = "#{sample.bottles_number} frascos"
    #  end
    #  sample.save
    #end
    remove_column :samples, :bottles_number, :int, null: false, default: 1
  end
end
