class StockOutsController < ApplicationController

  def new
    product = Product.find params[:id]
  end

end
