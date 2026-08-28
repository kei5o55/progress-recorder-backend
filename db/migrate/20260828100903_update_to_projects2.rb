class UpdateToProjects2 < ActiveRecord::Migration[8.1]
  def change
    change_column :projects, :target_hours, :integer
  end
end
