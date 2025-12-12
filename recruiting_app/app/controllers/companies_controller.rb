class CompaniesController < ApplicationController
  before_action :require_login
  before_action :set_company, only: [:show, :edit, :update, :destroy, :toggle_client_status]
  
  def index
    @clients = Company.where(is_client: true).order(:company_name)
    @client_prospects = Company.where(is_client: false).order(:company_name)
  end
  
  def clients
    @clients = Company.where(is_client: true).order(:company_name)
    render :clients
  end
  
  def client_prospects
    @client_prospects = Company.where(is_client: false).order(:company_name)
    render :client_prospects
  end

  def show
    @hiring_team_members = @company.hiring_team_members
    @jobs = @company.jobs
    @candidates = @company.candidates
  end

  def new
    @company = Company.new
    @company.is_client = params[:is_client] == 'true'
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company, notice: "#{@company.is_client ? 'Client' : 'Client Prospect'} was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "#{@company.is_client ? 'Client' : 'Client Prospect'} was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: "#{@company.is_client ? 'Client' : 'Client Prospect'} was successfully deleted."
  end
  
  def toggle_client_status
    @company.update(is_client: !@company.is_client)
    redirect_to @company, notice: "Status changed to #{@company.is_client ? 'Client' : 'Client Prospect'}."
  end
  
  def bulk_upload_form
    # Display the CSV upload form
  end
  
  def bulk_upload
    require 'csv'
    
    unless params[:csv_file].present?
      flash[:alert] = "Please select a CSV file to upload."
      render :bulk_upload_form and return
    end
    
    file = params[:csv_file]
    
    # Validate file type
    unless file.content_type == 'text/csv' || file.original_filename.end_with?('.csv')
      flash[:alert] = "Please upload a valid CSV file."
      render :bulk_upload_form and return
    end
    
    begin
      csv_data = CSV.parse(file.read, headers: true)
      
      # Validate required column (Company Name)
      unless csv_data.headers.include?('Company Name')
        flash[:alert] = "CSV file must include 'Company Name' column."
        render :bulk_upload_form and return
      end
      
      # Validate row count
      if csv_data.length > 100
        flash[:alert] = "File contains more than 100 rows. Contact us for file loads larger than 100 rows."
        render :bulk_upload_form and return
      end
      
      # Process each row
      created_count = 0
      csv_data.each do |row|
        company = Company.new(
          company_name: row['Company Name'],
          address_1: row['Address 1'],
          address_2: row['Address 2'],
          city: row['City'],
          state: row['State'],
          zip_code: row['Zip'],
          url: row['URL'],
          jobs_url: row['Jobs URL'],
          phone_number: row['Phone Number'],
          headcount: row['Headcount'],
          investors_memo: row['Investors Memo'],
          is_client: false
        )
        
        if company.save
          created_count += 1
        end
      end
      
      redirect_to client_prospects_path, notice: "Successfully created #{created_count} client prospects."
    rescue CSV::MalformedCSVError
      flash[:alert] = "Invalid CSV file format."
      render :bulk_upload_form
    rescue => e
      flash[:alert] = "Error processing CSV file: #{e.message}"
      render :bulk_upload_form
    end
  end

  private
  
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:company_name, :url, :jobs_url, :phone_number, :description, 
                                   :headcount, :address_1, :address_2, :city, :state, 
                                   :zip_code, :is_client, :priority, :notes, :investors_memo)
  end
end
