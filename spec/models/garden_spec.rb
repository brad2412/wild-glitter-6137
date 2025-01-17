require "rails_helper"

RSpec.describe Garden, type: :model do
  before(:each) do
    @garden1 = Garden.create!(name: "garden1", organic: true)

    @p1 = Plot.create!(number: "1", size: "small", direction: "North", garden_id: @garden1.id)
    @p2 = Plot.create!(number: "2", size: "medium", direction: "South", garden_id: @garden1.id)

    @plant1 = Plant.create!(name: "strawberry", description: "sweet", days_to_harvest: 1)
    @plant2 = Plant.create!(name: "pepper", description: "hot", days_to_harvest: 2)
    @plant3 = Plant.create!(name: "peach", description: "juicy", days_to_harvest: 101)

    @plant_plot1 = PlantPlot.create!(plot: @p1, plant: @plant1)
    @plant_plot2 = PlantPlot.create!(plot: @p1, plant: @plant2)
    @plant_plot3 = PlantPlot.create!(plot: @p2, plant: @plant3)
    @plant_plot4 = PlantPlot.create!(plot: @p2, plant: @plant1)
  end
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe "under_100_days" do
    it "should return plants with under 100 days to harvest" do
      expect(@garden1.under_100_days).to eq([@plant1, @plant2])
      expect(@garden1.under_100_days).to_not eq([@plant3])
    end
  end
end