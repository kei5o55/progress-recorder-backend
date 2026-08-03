class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.date :due_date
      t.text :memo
      t.decimal :target_hours
      t.integer :pomodoro_work_minutes
      t.integer :pomodoro_break_minutes
      t.date :start_date
      t.date :end_date
      t.string :color

      t.timestamps
    end
  end
end
