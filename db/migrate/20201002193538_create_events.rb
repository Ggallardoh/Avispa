class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :image
      t.string :slug
      t.datetime :start_date
      t.datetime :publish_date
      t.string :state
      t.integer :available_tickets
      t.integer :price

      t.timestamps
    end
  end
end
