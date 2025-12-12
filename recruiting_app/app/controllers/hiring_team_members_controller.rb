class HiringTeamMembersController < ApplicationController
  before_action :require_login
  before_action :set_company
  before_action :set_hiring_team_member, only: [:edit, :update, :destroy]
  
  def new
    @hiring_team_member = @company.hiring_team_members.build
  end

  def create
    @hiring_team_member = @company.hiring_team_members.build(hiring_team_member_params)
    if @hiring_team_member.save
      redirect_to @company, notice: "Hiring team member was successfully added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @hiring_team_member.update(hiring_team_member_params)
      redirect_to @company, notice: "Hiring team member was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hiring_team_member.destroy
    redirect_to @company, notice: "Hiring team member was successfully removed."
  end

  private
  
  def set_company
    @company = Company.find(params[:company_id])
  end
  
  def set_hiring_team_member
    @hiring_team_member = @company.hiring_team_members.find(params[:id])
  end

  def hiring_team_member_params
    params.require(:hiring_team_member).permit(:name, :title, :phone_number, :email, :linkedin_url)
  end
end
