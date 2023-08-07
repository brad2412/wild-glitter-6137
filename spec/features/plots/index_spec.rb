require "rails_helper"

RSpec.describe "plots index" do
  before(:each) do
  @garden1 = Garden.create!(name: "garden1", organic: true)

  @p1 = Plot.create!(number: "1", size: "small", direction: "North", garden_id: @garden1.id)
  @p2 = Plot.create!(number: "2", size: "medium", direction: "South", garden_id: @garden1.id)

  @plant1 = Plant.create!(name: "strawberry", description: "sweet", days_to_harvest: 1)
  @plant2 = Plant.create!(name: "pepper", description: "hot", days_to_harvest: 2)
  @plant3 = Plant.create!(name: "peach", description: "juicy", days_to_harvest: 3)

  @plant_plot1 = PlantPlot.create!(plot: @p1, plant: @plant1)
  @plant_plot2 = PlantPlot.create!(plot: @p1, plant: @plant2)
  @plant_plot3 = PlantPlot.create!(plot: @p2, plant: @plant3)

  end
  it "should have list of all plot numbers with name of all plots names" do
    visit "/plots"
    # save_and_open_page
    expect(page).to have_content(@p1.number)
    expect(page).to have_content(@p2.number)
  
    expect(page).to have_content(@plant1.name, count: 1)
    expect(page).to have_content(@plant2.name, count: 1)
    expect(page).to have_content(@plant3.name, count: 1)

  end
end

# User Story 1, Plots Index Page

# As a visitor
# When I visit the plots index page ('/plots')
# I see a list of all plot numbers
# And under each plot number I see the names of all that plot's plants