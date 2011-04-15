class CreateAtms < ActiveRecord::Migration
  def self.up
    create_table :atms do |t|
      t.decimal :balance

      t.timestamps
    end
  end

  def self.down
    drop_table :atms
  end
end
