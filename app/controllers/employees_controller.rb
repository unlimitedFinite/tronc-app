class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @employees = Employee.where(user: current_user).all
  end

  def new
    @employee = Employee.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  def edit
    respond_to do |f|
      f.html
      f.js
    end
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.user = current_user
    respond_to do |format|
      if @employee.save
        format.html { redirect_to employees_path, notice: 'Employee was created!' }
        format.json { render :index, status: :created }
      else
        format.html { render :index }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :active)
    end
end
