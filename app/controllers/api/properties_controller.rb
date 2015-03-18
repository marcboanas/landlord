class Api::PropertiesController < ApplicationController
  respond_to :json

  def index
    respond_with Property.all
  end

  def show
    respond_with Property.find(params[:id])
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      respond_with @property, location: api_property_path(@property)
    else
      respond_with Property.create(property_params)
    end
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
