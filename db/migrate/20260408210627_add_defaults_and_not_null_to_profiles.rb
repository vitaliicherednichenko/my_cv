class AddDefaultsAndNotNullToProfiles < ActiveRecord::Migration[7.1]
  def up
    change_column_default :profiles, :full_name, 'Unknown'
    change_column_default :profiles, :title, 'Unknown'

    change_column_null :profiles, :full_name, false
    change_column_null :profiles, :title, false
  end

  def down
    change_column_null :profiles, :full_name, true
    change_column_null :profiles, :title, true

    change_column_default :profiles, :full_name, nil
    change_column_default :profiles, :title, nil
  end
end
