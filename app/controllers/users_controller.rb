class UsersController < ApplicationController
    load_and_authorize_resource

    # GET /users or /users.json
    def index
      @users = User.all
    end
  
    # GET /users/1 or /users/1.json
    def show
      if @user.role == "employee"
        @branch_office = BranchOffice.return_branch_office(@user.branch_office_id)
      end
    end 
  
    # GET /users/new
    def new
      @user = User.new
      @ok = true
    end
  
    # GET /users/1/edit
    def edit
      @ok = false
    end
  
    def administrator
      if @user.role == "administrator"
        @user.branch_office_id = nil
      end
    end

    # POST /users or /users.json
    def create
      @user = User.new(user_params)
      administrator
      respond_to do |format|
        if @user.save
          format.html { redirect_to user_url(@user), notice: "User was successfully created."}
          format.json { render :show, status: :created, location: @user }
        else
          @ok = true
          @ok_2 = false
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /users/1 or /users/1.json
    def update
      administrator
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          @ok = false
          @ok_2 = true
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /users/1 or /users/1.json
    def destroy
      respond_to do |format|
      if @user.role == "client" || @user.role == "employee"
        Turn.destroy_turns_users(@user.id)
      end
      @user.destroy
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role, :branch_office_id)
      end
  end
  