class CreateWorkSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :work_sessions, id: :uuid do |t|
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.datetime :started_at
      t.datetime :ended_at
      t.datetime :paused_at
      t.text :note
      t.string :status
      t.string :timer_mode
      t.integer :pomodoro_count
      t.integer :pomodoro_work_minutes
      t.integer :pomodoro_break_minutes

      t.timestamps
    end
  end
end