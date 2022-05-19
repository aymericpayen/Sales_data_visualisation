require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe SuperstoresController, type: :controller do
  describe "GET #index" do
    it "returns the correct sum of all sales" do
      sum = Superstore.superstores_revenue(Superstore.all)
      expect(sum).to eq(2297200.86)
    end
  end
end
