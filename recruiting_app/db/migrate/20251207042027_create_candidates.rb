class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.string :grade
      t.string :source
      t.string :first_name
      t.string :last_name
      t.string :linkedin
      t.string :email
      t.string :phone
      t.string :github
      t.string :blog
      t.text :fun
      t.text :tech_stack
      t.text :resume_text

      t.timestamps
    end
  end
end
