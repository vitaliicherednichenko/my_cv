class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :title
      t.string :phone
      t.string :email
      t.string :location
      t.text :summary
      t.string :github_url
      t.string :linkedin_url

      t.timestamps
    end
  end
end
