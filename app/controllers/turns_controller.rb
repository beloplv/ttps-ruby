class TurnsController < ApplicationController
  load_and_authorize_resource

  # GET /turns or /turns.json
  def index
    if current_user.role == "client"
      @turns = Turn.return_turns_client(current_user.id)
    else
      @turns = Turn.return_turns_employee(current_user.id)
    end
  end

  # GET /turns/1 or /turns/1.json
  def show
    @in_progress = BranchOfficesSchedule.in_progress?(@turn.status)
    @user= User.return_user(@turn.user_id)
    @employee = User.return_user(@turn.employee_id)
    @branch_office = BranchOffice.return_branch_office(@turn.branch_office_id)
  end
 
  # GET /turns/new
  def new
    @turn = Turn.new
  end

  # GET /turns/1/edit
  def edit
    @in_progress = BranchOfficesSchedule.in_progress?(@turn.status)
    @user= User.return_user(@turn.user_id)
    @branch_office = BranchOffice.return_branch_office(@turn.branch_office_id)
  end

  # POST /turns or /turns.json
  def create
    @turn = Turn.new(turn_params)
    @turn.user_id = current_user.id
    respond_to do |format|
      if BranchOfficesSchedule.valid_turn?(turn_params["branch_office_id"], turn_params["date"], turn_params["hour"])
        if @turn.save
          format.html { redirect_to turn_url(@turn), notice: "Turn was successfully created." }
          format.json { render :show, status: :created, location: @turn }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      else
        @turn.errors.add(:date, :invalid, :message => ": There is no shift available for that day and time")
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_client
    respond_to do |format|
      if BranchOfficesSchedule.valid_turn?(turn_params["branch_office_id"], turn_params["date"], turn_params["hour"])
          if @turn.update(turn_params)
            format.html { redirect_to turn_url(@turn), notice: "Turn was successfully updated." }
            format.json { render :show, status: :ok, location: @turn }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @turn.errors, status: :unprocessable_entity }
          end
        else
          @turn.errors.add(:date, :invalid, :message => ": There is no shift available for that day and time")
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      end
  end

  def update_employee
    respond_to do |format|
      @turn.status = "attended"
      @turn.employee_id = current_user.id
      if turn_params["result"] != ""
        if @turn.update(turn_params)
          format.html { redirect_to turn_url(@turn), notice: "Turn was successfully updated." }
          format.json { render :show, status: :ok, location: @turn }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @turn.errors, status: :unprocessable_entity }
        end
      else
        @turn.errors.add(:result, :invalid, :message => ": fill in the fields please")
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /turns/1 or /turns/1.json
  def update
    if current_user.role == "client"
      update_client
    else
      update_employee
    end
  end

  # DELETE /turns/1 or /turns/1.json
  def destroy
    @turn.destroy

    respond_to do |format|
      format.html { redirect_to turns_url, notice: "Turn was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turn
      @turn = Turn.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def turn_params
      params.require(:turn).permit(:date, :hour, :motive, :status, :branch_office_id, :employee_id, :result)
    end
end
