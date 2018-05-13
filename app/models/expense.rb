class Expense < ApplicationRecord
  belongs_to :trips, required: false

end
