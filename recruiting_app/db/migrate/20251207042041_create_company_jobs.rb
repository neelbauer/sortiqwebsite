class CreateCompanyJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :company_jobs do |t|
      t.references :company, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
