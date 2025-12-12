class JobsController < ApplicationController
  before_action :require_login
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  
  def index
    @jobs = Job.all.order(date_opened: :desc)
  end

  def show
    @companies = @job.companies
    @job_candidates = @job.job_candidates.includes(:candidate)
    @hiring_team_members = @companies.any? ? @companies.first.hiring_team_members : []
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      # Associate job with company if company_id is provided
      if params[:company_id].present?
        @job.companies << Company.find(params[:company_id])
      end
      redirect_to @job, notice: "Job was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: "Job was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url, notice: "Job was successfully deleted."
  end

  private
  
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:job_url, :hiring_manager, :tech_stack, :salary_range_low, 
                               :salary_range_high, :concise_description, :description, 
                               :date_opened, :job_title, :recruiting_notes, :notes, :site, :commute)
  end
end
