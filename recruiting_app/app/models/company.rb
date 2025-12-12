class Company < ApplicationRecord
  PRIORITIES = ['A', 'B', 'C', 'D', 'F', 'TBD'].freeze
  
  has_many :hiring_team_members, dependent: :destroy
  has_many :company_jobs, dependent: :destroy
  has_many :jobs, through: :company_jobs
  has_many :company_candidates, dependent: :destroy
  has_many :candidates, through: :company_candidates
  
  validates :company_name, presence: true
  
  after_initialize :set_default_priority, if: :new_record?
  
  private
  
  def set_default_priority
    self.priority ||= 'TBD'
  end
end
