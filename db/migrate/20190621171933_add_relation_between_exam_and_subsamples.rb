class AddRelationBetweenExamAndSubsamples < ActiveRecord::Migration
  def change
  	 add_reference :exams, :subsample, index: true
  end
end
