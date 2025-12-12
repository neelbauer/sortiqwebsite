class AddRecruitingNotesToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :recruiting_notes, :text
  end
end
