require 'date'
require 'groupdate'

class SuperstoresController < ApplicationController
  def index
    @superstores_revenue = nil
    @superstores_revenue_per_order = nil
    @superstores_customers = nil
    @superstores=Superstore.all
    # Stores all the state present in the CSV
    @superstores_state = @superstores.select(:state).map(&:state).uniq.sort
    if params[:state] == "All states"
      # Sums all the sales
      @superstores_revenue = @superstores.sum(:sales).truncate(2)
      # Average revenue per order
      @superstores_revenue_per_order=@superstores.sum(:sales)/Superstore.select(:order_id).distinct.count
      @superstores_revenue_per_order = @superstores_revenue_per_order.truncate(2)
      # Counts of all unique customers
      @superstores_customers = @superstores.select(:customer_id).distinct.count
      @super_stores_group_by_month_year = @superstores.group_by { |superstore| Date.strptime(superstore.order_date) }
      @super_stores_group_by_month_year = @super_stores_group_by_month_year.sort
      # Sums of sales ordered by month/year
      @superstores_sales_per_month_graph = @superstores.group_by_month(:order_date, format: "%m/%Y").sum(:sales)
    elsif @superstores_state.include?(params[:state])
      #Select all the purchases made in the selected params[:state]]
      @superstores = @superstores.where(state: params[:state])
      # Sums all the sales in the selected params[:state]
      @superstores_revenue = @superstores.sum(:sales).truncate(2)
      # Counts of all unique customers in the selected params[:state]
      @superstores_revenue_per_order = @superstores.sum(:sales)/@superstores.select(:order_id).distinct.count
      # Counts of all unique customers in the selected params[:state]
      @superstores_customers = @superstores.select(:customer_id).distinct.count
      # Computation of the amount of sales per month/year in the selected params[:state]
      @superstores_sales_per_month_graph = @superstores.where(state: params[:state]).group_by_month(:order_date, format: "%m/%Y").sum(:sales)
    end
  end

  private

  def superstores_params
    params.require(:superstore).permit(:state)
  end
end
