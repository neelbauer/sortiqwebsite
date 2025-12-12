class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :job_url
      t.string :hiring_manager
      t.text :tech_stack
      t.integer :salary_range_low
      t.integer :salary_range_high
      t.string :concise_description
      t.text :description
      t.date :date_opened

      t.timestamps
    end
  end
end
