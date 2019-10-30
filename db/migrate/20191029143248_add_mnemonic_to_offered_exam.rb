class AddMnemonicToOfferedExam < ActiveRecord::Migration[5.2]
  def change
    add_column :offered_exams, :mnemonyc, :string
  end

end
