class Sulten::ReservationTypesController < ApplicationController
  def index
    @types = Sulten::ReservationType.all
  end

  def new
    @type = Sulten::ReservationType.new
  end

  def show
    @type = Sulten::ReservationType.find(params[:id])
  end

  def edit
    @type = Sulten::ReservationType.find(params[:id])
  end

  def update
    @type = Sulten::ReservationType.find(params[:id])
    if @type.update_attributes(params[:sulten_reservation_type])
      redirect_to sulten_reservation_types_path
    else
      render :edit
    end
  end

  def destroy
    Sulten::ReservationType.find(params[:id]).destroy
    redirect_to sulten_reservation_types_path
  end

  def create
    @type = Sulten::ReservationType.new(params[:sulten_reservation_type])
    if @type.save
      flash[:success] = t("helpers.models.sulten.reservation_type.success.create")
      redirect_to @type
    else
      flash.now[:error] = t("helpers.models.sulten.reservation_type.errors.create")
      render :new
    end
  end
end
