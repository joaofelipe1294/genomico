class AddRelationBetweenExamAndSubsamples < ActiveRecord::Migration[5.2]
  def change
  	 add_reference :exams, :subsample, index: true
  end
end
