# frozen_string_literal: true

class CarsController < ApplicationController
  def index
    cars = Car.where(nil)
    cars = cars.where(make: params[:make]) if params[:make].present?
    cars = order(cars, params[:order_by]) if params[:order_by].present?
    render json: cars
  end

  def show
    car = Car.find_by(model_id: params[:model_id])
    if car.present?
      render json: car
    else
      render plain: "Not found!", status: 404
    end
  end

  # Use the DB stored column names for the price and range attributes
  def order(relation, attribute)
    case attribute
    when "price"
      relation.order(:price_num)
    when "range"
      relation.order(:range_num)
    else
      relation.order(attribute)
    end
  end
end
