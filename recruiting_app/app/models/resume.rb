class Resume < ApplicationRecord
  belongs_to :candidate
  
  validates :filename, presence: true
end
