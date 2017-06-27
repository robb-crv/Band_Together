class AddHoursToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :duration, :float
  end
end
