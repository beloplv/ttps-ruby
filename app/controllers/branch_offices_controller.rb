class BranchOfficesController < ApplicationController
  load_and_authorize_resource

  # GET /branch_offices or /branch_offices.json
  def index
    @branch_offices = BranchOffice.all
  end

  # GET /branch_offices/1 or /branch_offices/1.json
  def show
    @locality = Locality.return_locality(@branch_office.locality_id)
  end

  # GET /branch_offices/new
  def new
    @branch_office = BranchOffice.new
  end

  # GET /branch_offices/1/edit
  def edit
  end

  # POST /branch_offices or /branch_offices.json
  def create
    @branch_office = BranchOffice.new(branch_office_params)

    respond_to do |format|
      if @branch_office.valid?
        if @branch_office.save
          format.html { redirect_to branch_office_url(@branch_office), notice: "Branch office was successfully created." }
          format.json { render :show, status: :created, location: @branch_office }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @branch_office.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branch_offices/1 or /branch_offices/1.json
  def update
    respond_to do |format|
      if @branch_office.valid?
        if @branch_office.update(branch_office_params)
          format.html { redirect_to branch_office_url(@branch_office), notice: "Branch office was successfully updated." }
          format.json { render :show, status: :ok, location: @branch_office }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @branch_office.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branch_offices/1 or /branch_offices/1.json
  def destroy
    @locality = Locality.return_locality(@branch_office.locality_id)
    respond_to do |format|
      if User.valid_destroy_branch_office?(@branch_office.id) && Turn.valid_destroy_branch_office?(@branch_office.id)
        @branch_office.destroy
        format.html { redirect_to branch_offices_url, notice: "Branch office was successfully destroyed." }
        format.json { head :no_content }
      else
        @branch_office.errors.add(:id, :invalid, :message => ": This branch office has turns or employed users. Cannot be deleted")
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @branch_office.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch_office
      @branch_office = BranchOffice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_office_params
      params.require(:branch_office).permit(:name, :address, :phone, :locality_id)
    end
end
