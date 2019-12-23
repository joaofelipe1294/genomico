class StockOutsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter

  def index
    @stock_outs = StockOut.all.order(:date).page params[:page]
  end

  def new
    @stock_out = StockOut.new({
        product: Product.find(params[:id])
      })
    set_users
  end

  def create
    @stock_out = StockOut.new stock_out_params
    if @stock_out.save
      flash[:success] = I18n.t :new_stock_out_success
      redirect_to stock_outs_path
    else
      redirect_to new_stock_out_path(@stock_out.product)
    end
  end

  private

    def stock_out_params
      params.require(:stock_out).permit(:responsible_id, :date, :product_id)
    end

end
