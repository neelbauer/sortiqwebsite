class JobCandidate < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  
  STAGES = [
    'applied',
    'referred',
    'identified',
    'contacted', 
    'screened',
    'tech screened',
    'interview',
    'references',
    'refs checked',
    'make offer',
    'offer made',
    'offer accepted',
    'offer rejected',
    'rejected',
    'pass',
    'hold',
    'withdrew'
  ].freeze
  
  validates :stage, inclusion: { in: STAGES }, allow_blank: true
  validates :job_id, uniqueness: { scope: :candidate_id }
end
