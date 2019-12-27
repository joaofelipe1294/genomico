class StockOutsController < ApplicationController
  include InstanceVariableSetter
  before_action :user_filter

  def index
    @stock_outs = StockOut.all.order(date: :desc).page params[:page]
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
      redirect
    else
      redirect_to new_stock_out_path(@stock_out.product)
    end
  end

  private

    def stock_out_params
      params.require(:stock_out).permit(:responsible_id, :date, :product_id)
    end

    def redirect
      next_product = @stock_out.product.find_next_in_stock
      if next_product
        return redirect_to next_product_to_open_path(next_product)
      else
        flash[:warning] = I18n.t :without_product_to_open_in_stock
        return redirect_to stock_outs_path
      end
    end

end
