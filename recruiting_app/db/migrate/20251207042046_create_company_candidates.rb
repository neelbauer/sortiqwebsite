class CreateCompanyCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :company_candidates do |t|
      t.references :company, null: false, foreign_key: true
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
