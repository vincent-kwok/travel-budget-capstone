class Trip < ApplicationRecord
  belongs_to :user



  # def recommendations
  #   # Make Unirest requests
  # end

  # def as_json_with_recommendations
  #   {
  #     id: id,
  #     name: name,
  #     recommendations: recommendations
  #   }
  # end
end