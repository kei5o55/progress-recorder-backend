class CreateCalendarMemos < ActiveRecord::Migration[8.0]
  def change
    create_table :calendar_memos, id: :uuid do |t|
      t.date :date
      t.text :text

      t.timestamps
    end
  end
end