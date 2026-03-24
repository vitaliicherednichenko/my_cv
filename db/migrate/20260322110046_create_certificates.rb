class CreateCertificates < ActiveRecord::Migration[7.1]
  def change
    create_table :certificates do |t|
      t.string :name
      t.string :provider
      t.date :issue_date
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
