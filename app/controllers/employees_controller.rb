class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    
    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
        # $exch.publish("Created: #{@employee.as_json}", :routing_key => $dyn_queue.name)
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        # $exch.publish("Error: #{@employee.errors.as_json}", :routing_key => $dyn_queue.name)
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
        # $exch.publish("Updated: #{@employee.as_json}", :routing_key => $dyn_queue.name)
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
        # $exch.publish("Error: #{@employee.errors.as_json}", :routing_key => $dyn_queue.name)
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    msgStr = "#{@employee.as_json}"
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
      # $exch.publish("Deleted: #{msgStr}", :routing_key => $dyn_queue.name)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :hiredate, :salary, :fulltime, :vacationdays, :comments)
    end
end
