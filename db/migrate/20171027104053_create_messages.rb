class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :text # add info  to database
      t.timestamps
    end
  end
e n
