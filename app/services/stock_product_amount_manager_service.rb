class StockProductAmountManagerService

  def initialize product, operation
    @product = product
    @operation = operation
  end

  def call
    if @operation == :add_to_stock
      current_state = @product.current_state
      if current_state == CurrentState.STOCK
        { total_aviable: increate_total_aviable }
      elsif current_state == CurrentState.IN_USE
        { total_in_use: increase_total_in_use }
      end
    elsif @operation == :change_to_in_use
      {
        total_in_use: increase_total_in_use,
        total_aviable: decreate_total_aviable
      }
    elsif @operation == :stock_out
      { total_in_use: decrease_total_in_use }
    end
  end

  private

    def increate_total_aviable
      current_total_aviable = @product.stock_product.total_aviable
      current_total_aviable + @product.amount
    end

    def increase_total_in_use
      current_total_in_use = @product.stock_product.total_in_use
      current_total_in_use + @product.amount
    end

    def decreate_total_aviable
      current_total_aviable = @product.stock_product.total_aviable
      current_total_aviable - @product.amount
    end

    def decrease_total_in_use
      current_total_in_use = @product.stock_product.total_in_use
      current_total_in_use - @product.amount
    end

end
