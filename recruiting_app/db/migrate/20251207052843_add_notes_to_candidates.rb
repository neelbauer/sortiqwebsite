class AddNotesToCandidates < ActiveRecord::Migration[8.0]
  def change
    add_column :candidates, :notes, :text
  end
end
