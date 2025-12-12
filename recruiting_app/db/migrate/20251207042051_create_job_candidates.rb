class CreateJobCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :job_candidates do |t|
      t.references :job, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true
      t.string :stage

      t.timestamps
    end
  end
end
