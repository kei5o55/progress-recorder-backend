class CreateDaySchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :day_schedules, id: :uuid do |t|
      t.references :project, null: true, foreign_key: true, type: :uuid
      t.date :date
      t.string :title
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute
      t.string :color

      t.timestamps
    end
  end
end