class CompanyCandidate < ApplicationRecord
  belongs_to :company
  belongs_to :candidate
  
  validates :company_id, uniqueness: { scope: :candidate_id }
end
