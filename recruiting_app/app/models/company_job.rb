class CompanyJob < ApplicationRecord
  belongs_to :company
  belongs_to :job
  
  validates :company_id, uniqueness: { scope: :job_id }
end
