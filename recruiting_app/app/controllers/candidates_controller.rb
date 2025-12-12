class CandidatesController < ApplicationController
  before_action :require_login
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  
  def index
    @candidates = Candidate.all.order(:last_name, :first_name)
  end

  def show
    @resumes = @candidate.resumes
    @jobs = @candidate.jobs
    @companies = @candidate.companies
    @job_candidates = @candidate.job_candidates.includes(:job)
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to @candidate, notice: "Candidate was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: "Candidate was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_url, notice: "Candidate was successfully deleted."
  end

  private
  
  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:grade, :source, :first_name, :last_name, 
                                     :linkedin, :email, :phone, :github, :blog, 
                                     :fun, :tech_stack, :resume_text, :role, :notes, resume_files: [])
  end
end
