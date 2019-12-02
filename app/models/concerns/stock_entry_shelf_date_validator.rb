class StockEntryShelfDateValidator < ActiveModel::Validator

  def validate record
    if record.has_shelf_life == true && record.shelf_life.nil?
      record.errors[:shelf_life] << "não pode ficar em branco"
    end
  end

end
