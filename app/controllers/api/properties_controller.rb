class Api::PropertiesController < ApplicationController
  respond_to :json

  def index
    respond_with Property.all
  end

  def show
    respond_with Property.find(params[:id])
  end

  def create
    respond_with @property = Property.create(property_params), location: api_property_path(@property)
  end

  def update
    respond_with Property.update(params[:id], property_params)
  end

  def delete
    respond_with Property.destroy(params[:id])
  end

  private

  def property_params
    params.require(:property).permit(:name, :empty)
  end
end
