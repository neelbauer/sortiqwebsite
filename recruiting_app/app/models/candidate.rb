class Candidate < ApplicationRecord
  GRADES = ['A', 'B', 'C', 'D', 'F', 'TBD'].freeze
  
  has_many_attached :resume_files
  has_many :resumes, dependent: :destroy
  has_many :company_candidates, dependent: :destroy
  has_many :companies, through: :company_candidates
  has_many :job_candidates, dependent: :destroy
  has_many :jobs, through: :job_candidates
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  validate :resume_files_format
  
  after_initialize :set_default_grade, if: :new_record?
  
  private
  
  def set_default_grade
    self.grade ||= 'TBD'
  end
  
  def resume_files_format
    return unless resume_files.attached?
    
    resume_files.each do |file|
      unless file.content_type.in?(%w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document])
        errors.add(:resume_files, 'must be a PDF, DOC, or DOCX file')
      end
    end
  end
end
