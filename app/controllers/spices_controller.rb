class SpicesController < ApplicationController
  wrap_parameters format: []

  # exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found
  
  def index
    render json: Spice.all, status: :ok
  end

  def show
    spice = get_spice
    render json: spice, status: :ok
  end 

  def update
    spice =  get_spice
    spice.update(spice_params)
    render json: spice, status: :ok
  end 

  def destroy
    spice = get_spice
    spice.destroy
    head :no_content
  end 




  private

  def get_spice 
    Spice.find(params[:id])
  end 

  def spice_not_found
    render json: { "Error": "Spice not found" }, status: :not_found
  end 

  # helper method  filter functions
  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end 
end
