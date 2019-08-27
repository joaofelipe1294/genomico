class AddRelationBetweenInternalCodesAndExams < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :internal_code
    add_reference :internal_codes, :subsampl

    Sample.all.each do |sample|
      unless sample.internal_codes.empty?
        internal_code =  sample.internal_codes.first
        internal_code.save
      end
    end

    Exam.all.each do |exam|
      unless exam.sample_id.nil?
        sample = Sample.find exam.sample_id
        internal_code = sample.internal_codes.first
        exam.internal_code = internal_code
        exam.save
      end
    end
    
    remove_column :exams, :sample_id
    remove_column :exams, :subsample_id
    remove_column :exams, :uses_subsample
  end
end
