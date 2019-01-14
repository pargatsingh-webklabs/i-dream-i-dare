class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :super_admin_user, only: [:index, :destroy, :show, :edit, :update, :new]

  # GET /companies
  def index
    @companies = Company.all 
  end

  # GET /companies/1
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  def create
    newCompany = Company.new(company_params)

    # ADD AN ADMIN USER WITH THE FOLLOWING LOGIN/PASSWORD:
    n = newCompany.name.gsub(/[^0-9A-Za-z]/, '').downcase
    newUserEmail =  n[0,7] + "@admin.admin"
    newUserPassword = n[0,4] + "-5up3r!"

    u = User.new
    u.email = newUserEmail
    u.password = newUserPassword
    u.is_a_coach = false
    u.is_an_admin = true
    u.first_name = "Admin"
    u.last_name = "Admin"
    u.is_active = true
    u.is_deleted = false
    u.company_id = newCompany.id


    if newCompany.save and u.save
      redirect_to "/", notice: 'Company was successfully created, along with an admin user.'
    else
      render :new
    end
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /companies/1
  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully destroyed.'
  end

  def super_admin_user
    redirect_to 'index' unless current_user != nil && current_user.is_super_admin?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:logo_path, :name, :description, :logo_filename, :active)
    end
end
