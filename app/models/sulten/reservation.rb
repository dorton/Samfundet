class Sulten::Reservation < ActiveRecord::Base
  belongs_to :table
  belongs_to :reservation_type

  attr_accessible :reservation_from, :reservation_duration, :reservation_to, :people, :name,
    :telephone, :email, :allergies, :internal_comment, :table_id, :reservation_type_id, :reservation_duration, :errors

  attr_accessor :reservation_duration

  validates_presence_of :reservation_from, :reservation_to, :reservation_duration, :people,
    :name, :telephone, :email, :reservation_type

  validate :check_amount_of_people, on: :create

  validates :email, email: true

  before_validation(on: :create) do
    should_break = false

    if not [30, 60, 90, 120].include? reservation_duration.to_i
      errors.add(:reservation_duration, I18n.t("helpers.models.sulten.reservation.errors.check_reservation_duration"))
      should_break = true
    end

    if reservation_from.nil?
      errors.add(:reservation_from, 'Invalid date format')
      should_break = true
    end

    return false if should_break

    self.reservation_to = reservation_from + reservation_duration.to_i.minutes
  end

  after_validation(on: :create) do
    self.table = Sulten::Reservation.find_table(reservation_from, reservation_to, people, reservation_type_id)

    unless self.table
      errors.add(:reservation_from,
                 I18n.t("helpers.models.sulten.reservation.errors.reservation_from.no_table_available"))
    end
  end

  def check_amount_of_people
    if people > 12
      errors.add(:people, I18n.t("helpers.models.sulten.reservation.errors.people.too_many_people"))
    elsif people < 1
      errors.add(:people, I18n.t("helpers.models.sulten.reservation.errors.people.too_few_people"))
    end
  end

  def first_name
    self.name.partition(" ").first
  end

  def self.find_table from, to, people, reservation_type_id
    if (from >= Date.tomorrow) and (Sulten::Reservation.lyche_open?(from, to))
      for i in 1..Sulten::ReservationType.all.length
        Sulten::Table.where("capacity >= ? and available = ?", people, true).order("capacity ASC").tables_with_i_reservation_types(i).find do |t|
          if t.reservation_types.pluck(:id).include? reservation_type_id
            if t.reservations.where("reservation_from > ? or reservation_to < ?", to, from).count == t.reservations.count
              return t
            end
          end
        end
      end
    end
    return nil
  end

  def self.lyche_open? from, to
    #TODO: Change these defaults when admin can set them
    #The values 16 .. 22 are the openinghours 
    return (16..22).include?(from.hour..to.hour)
  end

  def self.kitchen_open? from, to
    default_kitchen_opening_hour = Time.new(2015,01,01,16,00,00)
    default_kitchen_closing_hour = Time.new(2015,01,01,22,00,00)
    return (16..22).include?(from.hour..to.hour)
  end
end
