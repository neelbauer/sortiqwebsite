class CreateHiringTeamMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :hiring_team_members do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :title
      t.string :phone_number
      t.string :email
      t.string :linkedin_url

      t.timestamps
    end
  end
end
