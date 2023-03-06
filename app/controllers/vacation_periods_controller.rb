# frozen_string_literal: true

class VacationPeriodsController < ApplicationController
  before_action :set_vacation_period, only: %i[show edit update destroy]

  # GET /vacation_periods or /vacation_periods.json
  def index
    @vacation_periods = VacationPeriod.all
  end

  # GET /vacation_periods/1 or /vacation_periods/1.json
  def show; end

  # GET /vacation_periods/new
  def new
    @vacation_period = VacationPeriod.new
  end

  # GET /vacation_periods/1/edit
  def edit; end

  # POST /vacation_periods or /vacation_periods.json
  def create
    @service_response = Vacations::AssignService.call(service_params)

    @vacation_period = @service_response[:vacation_period]

    respond_to do |format|
      if @service_response[:valid]
        format.html do
          redirect_to vacation_period_url(@vacation_period), notice: 'Vacation period was successfully created.'
        end
        format.json { render :show, status: :created, location: @vacation_period }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service_response.verifications, status: :unprocessable_entity }
      end
    end
  end

  def service_params
    start_date = Date.new(params[:vacation_period]['start_date(1i)'].to_i,
                          params[:vacation_period]['start_date(2i)'].to_i,
                          params[:vacation_period]['start_date(3i)'].to_i)

    end_date = Date.new(params[:vacation_period]['end_date(1i)'].to_i,
                        params[:vacation_period]['end_date(2i)'].to_i,
                        params[:vacation_period]['end_date(3i)'].to_i)

    {
      start_date: start_date,
      end_date: end_date,
      collaborator_id: params[:collaborator][:id]
    }
  end

  # PATCH/PUT /vacation_periods/1 or /vacation_periods/1.json
  def update
    respond_to do |format|
      if @vacation_period.update(vacation_period_params)
        format.html do
          redirect_to vacation_period_url(@vacation_period), notice: 'Vacation period was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @vacation_period }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vacation_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacation_periods/1 or /vacation_periods/1.json
  def destroy
    @vacation_period.destroy

    respond_to do |format|
      format.html { redirect_to vacation_periods_url, notice: 'Vacation period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vacation_period
    @vacation_period = VacationPeriod.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vacation_period_params
    params.require(:vacation_period).permit(:start_date, :end_date, :collaborator_id)
  end
end
