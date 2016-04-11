class Sulten::ReservationsController < ApplicationController
  filter_access_to :archive, require: :manage

  def index
    @reservations = Sulten::Reservation.where(reservation_from: Time.now.beginning_of_week..Time.now.end_of_week).order("reservation_from")
  end

  def archive
    @reservations = Sulten::Reservation.where(reservation_from: Time.now.beginning_of_week..Time.now.next_year).order("reservation_from ASC")
  end

  def new
    @reservation = Sulten::Reservation.new
  end

  def create
    @reservation = Sulten::Reservation.new(params[:sulten_reservation])

    respond_to do |format|
      if @reservation.save
        SultenNotificationMailer.send_reservation_email(@reservation).deliver
        flash[:success] = t("helpers.models.sulten.reservation.success.create")
        format.json { render :json => { :redirect => success_sulten_reservations_path, :status => 200 } }
      else
        format.json { render :json => { :errors => @reservation.errors, :status => 422 } }
      end
    end

  end

  def show
    @reservation = Sulten::Reservation.find(params[:id])
  end

  def edit
    @reservation = Sulten::Reservation.find(params[:id])
  end

  def update
    @reservation = Sulten::Reservation.find params[:id]

    if @reservation.update_attributes(params[:sulten_reservation])
      flash[:success] = t("helpers.models.sulten.reservation.success.update")
      redirect_to @reservation
    else
      flash.now[:error] = t("helpers.models.sulten.reservation.errors.update_fail")
      render :edit
    end

  end

  def destroy
    Sulten::Reservation.find(params[:id]).destroy
    flash[:success] = t("helpers.models.sulten.reservation.success.delete")
    redirect_to sulten_reservations_path
  end

  def success
  end

  def available_periods
    respond_to do |format|
      first_period = Time.zone.parse(params[:from]).change(hour: 16)
      last_period = Time.zone.parse(params[:from]).change(hour: 22) - params[:duration].to_i.minutes
      periods = (first_period.to_i..last_period.to_i).step(30.minutes).map { |t| Time.zone.at(t).to_datetime }
      periods.delete_if {|period| not Sulten::Reservation.find_table(period, period + params[:duration].to_i.minutes, params[:people].to_i, params[:reservation_type_id].to_i)}

      format.json { render :json =>  periods}
    end
  end

  def modal
    render layout:false
  end
end
