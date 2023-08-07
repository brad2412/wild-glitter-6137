class PlantPlotsController < ApplicationController
  def destroy
    plant_plot = PlantPlot.find(params[:id])
    plant_plot.destroy
    redirect_to plots_path
  end
end
