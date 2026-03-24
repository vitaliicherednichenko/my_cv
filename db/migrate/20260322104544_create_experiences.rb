class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :company_name
      t.string :position
      t.string :location
      t.date :start_date
      t.date :end_date
      t.text :description
      t.boolean :current

      t.timestamps
    end
  end
end
