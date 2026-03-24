class CreateExperienceItems < ActiveRecord::Migration[7.1]
  def change
    create_table :experience_items do |t|
      t.references :experience, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
