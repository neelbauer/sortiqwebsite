class CreateResumes < ActiveRecord::Migration[8.0]
  def change
    create_table :resumes do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :filename
      t.string :content_type
      t.binary :file_data

      t.timestamps
    end
  end
end
