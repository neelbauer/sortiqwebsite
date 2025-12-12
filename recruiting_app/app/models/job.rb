class Job < ApplicationRecord
  SITE_OPTIONS = ['On-Site', 'Hybrid', 'Regional Remote', 'Remote'].freeze
  COMMUTE_OPTIONS = ['On-Site', 'Hybrid', 'Regional Remote', 'Remote'].freeze
  
  has_many :company_jobs, dependent: :destroy
  has_many :companies, through: :company_jobs
  has_many :job_candidates, dependent: :destroy
  has_many :candidates, through: :job_candidates
  
  validates :concise_description, presence: true
end
