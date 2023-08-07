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
  @plant_plot4 = PlantPlot.create!(plot: @p2, plant: @plant1)

  visit plots_path
  end
  it "should have list of all plot numbers with name of all plots names" do
    # save_and_open_page
    expect(page).to have_content(@p1.number)
    expect(page).to have_content(@p2.number)
  
    expect(page).to have_content(@plant1.name)
    expect(page).to have_content(@plant2.name)
    expect(page).to have_content(@plant3.name)

  end

  it "should remove a plant from a plot when clicking the 'Remove' link" do
    within("#plot1") do
      expect(page).to have_link("Remove #{@plant1.name} from plot #{@p1.number}")
      expect(page).to have_link("Remove #{@plant2.name} from plot #{@p1.number}")
      click_link("Remove #{@plant1.name} from plot #{@p1.number}")
      expect(current_path).to eq(plots_path)
      expect(page).to_not have_content(@plant1.name)
      save_and_open_page
    end


    within("#plot2") do
      expect(page).to have_link(@plant1.name)
    end
  end

  it "should still show other associated plants on the plot after removal" do
    within("#plot1") do
      expect(page).to have_link(@plant2.name)
    end

    within("#plot2") do
      expect(page).to have_link(@plant1.name)
      expect(page).to have_link(@plant3.name)
    end
  end
end

# User Story 2, Remove a Plant from a Plot

# As a visitor
# When I visit the plots index page
# Next to each plant's name
# I see a link to remove that plant from that plot
# When I click on that link
# I'm returned to the plots index page
# And I no longer see that plant listed under that plot,
# And I still see that plant's name under other plots that is was associated with.

# Note: you do not need to test for any sad paths or implement any flash messages. 