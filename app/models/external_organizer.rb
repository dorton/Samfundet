# -*- encoding : utf-8 -*-
class ExternalOrganizer < ActiveRecord::Base
  has_many :events, as: :organizer
end
