class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.belongs_to :customer

      t.timestamps
    end
    add_index :projects, :customer_id
  end
end
