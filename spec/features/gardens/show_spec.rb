require "rails_helper"

RSpec.describe "Garden show page" do
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
  
    visit garden_path(@garden1)
    end

  it "should show all plants in the garden with no duplicates and under 100 days to harvest" do

    expect(page).to have_content("Garden plants under 100 days to harvest")
    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to_not have_content(@plant3.name)
  end
end


# User Story 3, Garden's Plants

# As a visitor
# When I visit a garden's show page ('/gardens/:id')
# Then I see a list of plants that are included in that garden's plots
# And I see that this list is unique (no duplicate plants)
# And I see that this list only includes plants that take less than 100 days to harvest