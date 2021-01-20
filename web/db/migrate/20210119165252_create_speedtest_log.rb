class CreateSpeedtestLog < ActiveRecord::Migration[6.1]
  def change
    create_table :speedtest_log do |t|
      t.timestamp :timestamp
      t.float :download
      t.float :upload
      t.float :latency
    end
  end
end
