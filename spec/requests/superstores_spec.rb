require 'rails_helper'
require 'database_cleaner/active_record'

# Change this ArticlesController to your project
RSpec.describe SuperstoresController, type: :controller do
  describe "GET #index" do
    it "returns the correct sum of all sales" do
      superstores = Superstore.all
      sum = controller.superstores_revenue(superstores)
      expect(sum).to eq(2297200.86)
    end
    it "returns the correct average per order for \"All states\"" do
      superstores = Superstore.all
      sum = controller.superstores_average_revenue_per_order(superstores)
      expect(sum).to eq(458.61)
    end
    it "returns the correct number of customer \"All states\"'s arround" do
      superstores = Superstore.all
      sum = controller.superstores_customers(superstores)
      expect(sum).to eq(793)
    end
  end
end
