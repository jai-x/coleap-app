# frozen_string_literal: true

require "rails_helper"

RSpec.describe Car, type: :model do
  subject do
    Car.new(model_id: "24",
            make: "Tesla",
            model: "X",
            range_num: 450,
            range_unit: "km",
            colors: "red black",
            price_num: 110_000.00,
            price_currency: "EUR",
            photo_url: "https://example.com/tesla_x.jpg",)
  end

  describe "#as_json" do
    it "correctly replaces the hash keys" do
      expect(subject.as_json).to eq({
                                      "id" => "24",
                                      "make" => "Tesla",
                                      "model" => "X",
                                      "colors" => %w[red black],
                                      "photo" => "https://example.com/tesla_x.jpg",
                                      "range" => { "unit" => "km", "distance" => 450 },
                                      "price" => "110000.0 EUR",
                                    })
    end
  end
end
