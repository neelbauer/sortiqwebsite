class AddSiteToJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :jobs, :site, :string
  end
end
