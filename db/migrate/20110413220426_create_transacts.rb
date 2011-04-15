class CreateTransacts < ActiveRecord::Migration
  def self.up
    create_table :transacts do |t|
      t.decimal :amount
      t.references :user
      t.references :atm

      t.timestamps
    end
  end

  def self.down
    drop_table :transacts
  end
end
