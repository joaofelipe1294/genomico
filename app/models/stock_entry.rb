class StockEntry < ApplicationRecord
  # belongs_to :reagent
  # belongs_to :current_state
  belongs_to :responsible, class_name: :User
  validates :product, :entry_date, :responsible, presence: true
  # validates_with StockEntryShelfDateValidator
  # validates_with StockEntryAmountValidator
  # before_validation :default_is_expired
  # before_create :genertate_tag
  has_one :product
  accepts_nested_attributes_for :product
  paginates_per 10

  # private

    # def default_is_expired
    #   return if self.shelf_life.nil?
    #   if self.has_shelf_life
    #     if self.shelf_life < Date.current
    #       self.is_expired = true
    #     else
    #       self.is_expired = false
    #     end
    #   else
    #     self.is_expired = false
    #   end
    # end
    #
    # def genertate_tag
    #   return if self.reagent.nil?
    #   return if self.tag
    #   return if self.has_tag == false
    #   if self.reagent.field
    #     field_identifier = self.reagent.field.name[0, 3]
    #   else
    #     field_identifier = "ALL"
    #   end
    #   if self.reagent.field.nil?
    #     counter = StockEntry.joins(:reagent).where("reagents.field_id IS NULL").where(has_tag: true).size + 1
    #   else
    #     counter = StockEntry.joins(:reagent).where("reagents.field_id = ?", self.reagent.field_id).where(has_tag: true).size + 1
    #   end
    #   self.tag = "#{field_identifier}#{counter}"
    # end

end
