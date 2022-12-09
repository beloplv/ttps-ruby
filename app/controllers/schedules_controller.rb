class SchedulesController < ApplicationController
  load_and_authorize_resource

  # GET /schedules or /schedules.json
  def index
    @schedules = Schedule.all
  end

  # GET /schedules/1 or /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules or /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)
    respond_to do |format|
      if Schedule.valid_schedule(schedule_params["from"], schedule_params["to"])
        if @schedule.save
          format.html { redirect_to schedule_url(@schedule), notice: "Schedule was successfully created." }
          format.json { render :show, status: :created, location: @schedule }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @schedule.errors, status: :unprocessable_entity }
        end
      else
        @schedule.errors.add(:from, :invalid, :message => ": inconsistent time")
        @schedule.errors.add(:to, :invalid, :message => ": inconsistent time")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1 or /schedules/1.json
  def update
    respond_to do |format|
      if Schedule.valid_schedule(schedule_params["from"], schedule_params["to"])
        if @schedule.update(schedule_params)
          format.html { redirect_to schedule_url(@schedule), notice: "Schedule was successfully updated." }
          format.json { render :show, status: :ok, location: @schedule }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @schedule.errors, status: :unprocessable_entity }
        end
      else
        @schedule.errors.add(:from, :invalid, :message => ": inconsistent time")
        @schedule.errors.add(:to, :invalid, :message => ": inconsistent time")  
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1 or /schedules/1.json
  def destroy
    respond_to do |format|
    if BranchOfficesSchedule.valid_destroy_schedule?(@schedule.id)
      @schedule.destroy
      format.html { redirect_to schedules_url, notice: "Schedule was successfully destroyed." }
      format.json { head :no_content }
    else
      @schedule.errors.add(:id, :invalid, :message => ": This schedule belongs to an branch office. Cannot be deleted")
      format.html { render :show, status: :unprocessable_entity }
      format.json { render json: @schedule.errors, status: :unprocessable_entity }
    end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_params
      params.require(:schedule).permit(:day, :from, :to, :branch_office_id)
    end
end
