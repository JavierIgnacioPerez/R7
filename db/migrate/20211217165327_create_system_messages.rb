class CreateSystemMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :system_messages do |t|
      t.integer :connections
      t.text :message

      t.timestamps
    end
  end
end
