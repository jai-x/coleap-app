class Car < ApplicationRecord
  def as_json(options = {})
    hash = super(options)

    # replace DB ID with model ID
    hash["id"] = hash.delete("model_id")
    # break out range into a sub hash
    hash["range"] = { "unit" => hash.delete("range_unit"), "distance" => hash.delete("range_num") }
    # break out colors from a space sep list to string array
    hash["colors"] = hash["colors"].split
    # rejoin price from stored decimal to string
    hash["price"] = "#{hash.delete('price_num')} #{hash.delete('price_currency')}"
    # rename photo key
    hash["photo"] = hash.delete("photo_url")

    # remove unwanted fields
    hash.delete("created_at")
    hash.delete("updated_at")

    hash
  end
end
