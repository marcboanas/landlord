class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.boolean :empty, default: true

      t.timestamps null: false
    end
  end
end
