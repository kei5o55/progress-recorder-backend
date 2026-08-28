class DeleteTimerModeToWorkSessions < ActiveRecord::Migration[8.1]
  def change
    remove_column :work_sessions, :timer_mode, :string
  end
end
