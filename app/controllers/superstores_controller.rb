require 'date'
require 'groupdate'

class SuperstoresController < ApplicationController
  def index
    @superstores_revenue = nil
    @superstores_revenue_per_order = nil
    @superstores_customers = nil
    @superstores = Superstore.all
    # Stores all the state present in the CSV
    @superstores_state = @superstores.select(:state).map(&:state).uniq.sort
    if params[:state] == "All states"
      # Sums all the sales
      @superstores_revenue = superstores_revenue(@superstores)
      # Average revenue per order
      @superstores_revenue_per_order=superstores_average_revenue_per_order(@superstores)
      # Counts of all unique customers
      @superstores_customers = superstores_customers(@superstores)
      # Sums of sales ordered by month/year
      @superstores_sales_per_month_graph = superstores_sales_graph_per_month_year(@superstores)
    elsif @superstores_state.include?(params[:state])
      #Select all the purchases made in the selected params[:state]]
      @superstores = @superstores.where(state: params[:state])
      # Sums all the sales in the selected params[:state]
      @superstores_revenue = superstores_revenue(@superstores)
      # Average revenue per order
      @superstores_revenue_per_order=superstores_average_revenue_per_order(@superstores)
      # Counts of all unique customers in the selected params[:state]
     @superstores_customers = superstores_customers(@superstores)
      # Computation of the amount of sales per month/year in the selected params[:state]
      @superstores_sales_per_month_graph = superstores_sales_graph_per_month_year(@superstores)
    end
  end

  # Method to compute the sum of sale per as per selected 'superstores'
  def superstores_revenue(superstores)
    superstores.sum(:sales).truncate(2)
  end

  # Method the compute the average revenue per order as per selected 'superstores'
  def superstores_average_revenue_per_order(superstores)
    (superstores.sum(:sales)/superstores.select(:order_id).distinct.count).truncate(2)
  end

  # Method to compute the number of customer as per selected 'superstores'
  def superstores_customers(superstores)
    superstores.select(:customer_id).distinct.count
  end

  # Method to compute the data to display the graph of sales per month/year as per selected 'superstores'
  def superstores_sales_graph_per_month_year(superstores)
    superstores.group_by_month(:order_date, format: "%m/%Y").sum(:sales)
  end

  private

  def superstores_params
    params.require(:superstore).permit(:state)
  end
end
