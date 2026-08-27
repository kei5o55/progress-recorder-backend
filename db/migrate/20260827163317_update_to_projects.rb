class UpdateToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects,:completed, :boolean, null: false, default: false # 追加: 完了フラグ
    remove_column :projects, :start_date, :date
    remove_column :projects, :color, :string
  end
end
