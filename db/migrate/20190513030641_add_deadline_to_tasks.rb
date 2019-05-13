class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime, default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end
end
