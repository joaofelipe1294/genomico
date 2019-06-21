class ExamsController < ApplicationController
  
	def start
		@exam = Exam.find params[:id]
	end

  def new
  end

  def edit
  end
end
