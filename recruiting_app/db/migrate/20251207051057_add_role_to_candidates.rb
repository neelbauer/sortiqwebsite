class AddRoleToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :role, :string
  end
end
