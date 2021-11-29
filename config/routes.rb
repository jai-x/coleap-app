# frozen_string_literal: true

Rails.application.routes.draw do
  get "/cars", to: "cars#index"
  get "/cars/:model_id", to: "cars#show", as: "car"
end
