class BranchOfficesSchedulesController < ApplicationController
  load_and_authorize_resource

  # GET /branch_offices_schedules or /branch_offices_schedules.json
  def index
    @branch_offices_schedules = BranchOfficesSchedule.all
  end

  # GET /branch_offices_schedules/1 or /branch_offices_schedules/1.json
  def show
  end

  # GET /branch_offices_schedules/new
  def new
    @branch_offices_schedule = BranchOfficesSchedule.new
  end

  # GET /branch_offices_schedules/1/edit
  def edit
  end

  # POST /branch_offices_schedules or /branch_offices_schedules.json
  def create
    @branch_offices_schedule = BranchOfficesSchedule.new(branch_offices_schedule_params)

    respond_to do |format|
      if BranchOfficesSchedule.valid_branch_office_schedule(@branch_offices_schedule.branch_office_id, @branch_offices_schedule.schedule_id, false)
        if @branch_offices_schedule.save
          format.html { redirect_to branch_offices_schedule_url(@branch_offices_schedule), notice: "Branch offices schedule was successfully created." }
          format.json { render :show, status: :created, location: @branch_offices_schedule }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
        end
      else
        @branch_offices_schedule.errors.add(:schedule_id, :invalid, :message => ": there is already a schedule for that day in that branch office")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # PATCH/PUT /branch_offices_schedules/1 or /branch_offices_schedules/1.json
  def update
    respond_to do |format|
      if BranchOfficesSchedule.valid_branch_office_schedule(branch_offices_schedule_params["branch_office_id"], branch_offices_schedule_params["schedule_id"], true)
        if @branch_offices_schedule.update(branch_offices_schedule_params)
          format.html { redirect_to branch_offices_schedule_url(@branch_offices_schedule), notice: "Branch offices schedule was successfully updated." }
          format.json { render :show, status: :ok, location: @branch_offices_schedule }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
        end
      else
        @branch_offices_schedule.errors.add(:schedule_id, :invalid, :message => ": there is already a schedule for that day in that branch office")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branch_offices_schedules/1 or /branch_offices_schedules/1.json
  def destroy
    @branch_offices_schedule.destroy

    respond_to do |format|
      format.html { redirect_to branch_offices_schedules_url, notice: "Branch offices schedule was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch_offices_schedule
      @branch_offices_schedule = BranchOfficesSchedule.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_offices_schedule_params
      params.require(:branch_offices_schedule).permit(:branch_office_id, :schedule_id)
    end
end