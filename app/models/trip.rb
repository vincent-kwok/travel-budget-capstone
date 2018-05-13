class Trip < ApplicationRecord
  belongs_to :user
  has_many :expenses

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