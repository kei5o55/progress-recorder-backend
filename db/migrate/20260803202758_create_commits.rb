class CreateCommits < ActiveRecord::Migration[8.0]
  def change
    create_table :commits, id: :uuid do |t|
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :duration_ms, limit: 8 # bigint
      t.text :note

      t.timestamps
    end
  end
end