class PriceGroup < ActiveRecord::Base
  attr_accessible :name, :price

  validate :name, :price, presence: true
  validate :price, numericality: { only_integer: true }

  belongs_to :event
end
