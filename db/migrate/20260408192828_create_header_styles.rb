class CreateHeaderStyles < ActiveRecord::Migration[7.1]
  def change
    create_table :header_styles do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :bg_color
      t.string :text_color
      t.string :font
      t.integer :font_size
      t.boolean :bold

      t.timestamps
    end
  end
end
