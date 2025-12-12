class AddCommuteToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :commute, :string
  end
end
