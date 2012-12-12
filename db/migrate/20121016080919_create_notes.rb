class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :text
      # t.integer :customer_id
      t.belongs_to :customer

      t.timestamps
    end
  end
end
