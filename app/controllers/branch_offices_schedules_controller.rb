class BranchOfficesSchedulesController < ApplicationController
  load_and_authorize_resource

  # GET /branch_offices_schedules or /branch_offices_schedules.json
  def index
    @branch_offices_schedules = BranchOfficesSchedule.return_schedules(params[:branch_office_id])
    @branch_office = BranchOffice.return_branch_office(params[:branch_office_id])
  end

  # GET /branch_offices_schedules/1 or /branch_offices_schedules/1.json
  def show
    @branch_office = BranchOffice.return_branch_office(@branch_offices_schedule.branch_office_id)
    @schedule = Schedule.return_schedule(@branch_offices_schedule.schedule_id)
  end

  # GET /branch_offices_schedules/new
  def new
    @branch_offices_schedule = BranchOfficesSchedule.new
    @ok = false
  end

  # GET /branch_offices_schedules/1/edit
  def edit
    @ok = true
    @branch_office = BranchOffice.return_branch_office(@branch_offices_schedule.branch_office_id)
  end

  # POST /branch_offices_schedules or /branch_offices_schedules.json
  def create
    @branch_offices_schedule = BranchOfficesSchedule.new(branch_offices_schedule_params)

    respond_to do |format|
      if BranchOfficesSchedule.valid_branch_office_schedule?(@branch_offices_schedule.branch_office_id, @branch_offices_schedule.schedule_id)
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
    branch_offices_schedule_params["branch_office_id"] = @branch_offices_schedule.branch_office_id
    respond_to do |format|
      if Turn.valid_destroy_branch_offices_schedule?(@branch_offices_schedule.branch_office_id, @branch_offices_schedule.schedule_id)
        if BranchOfficesSchedule.valid_branch_office_schedule?(@branch_offices_schedule.branch_office_id, branch_offices_schedule_params["schedule_id"])
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
      else
        @branch_offices_schedule.errors.add(:schedule_id, :invalid, :message => ": The branch office has pending turns at that time. Cannot be update")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
      end 
    end
  end

  # DELETE /branch_offices_schedules/1 or /branch_offices_schedules/1.json
  def destroy
    @branch_office = BranchOffice.return_branch_office(@branch_offices_schedule.branch_office_id)
    @schedule = Schedule.return_schedule(@branch_offices_schedule.schedule_id)
    respond_to do |format|
    if Turn.valid_destroy_branch_offices_schedule?(@branch_offices_schedule.branch_office_id, @branch_offices_schedule.schedule_id)
      @branch_offices_schedule.destroy
      format.html { redirect_to branch_offices_url, notice: "Branch offices schedule was successfully destroyed." }
      format.json { head :no_content }
    else
      @branch_offices_schedule.errors.add(:id, :invalid, :message => ": The branch office has pending turns at that time. Cannot be deleted")
      format.html { render :show, status: :unprocessable_entity }
      format.json { render json: @branch_offices_schedule.errors, status: :unprocessable_entity }
    end
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
