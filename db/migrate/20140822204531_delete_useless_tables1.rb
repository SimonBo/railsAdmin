class DeleteUselessTables1 < ActiveRecord::Migration
  def change
    drop_table :ahoy_events
    drop_table :versions
  end
end
