class Sulten::TableReservationType < ActiveRecord::Base
  belongs_to :table
  belongs_to :reservation_type
end
