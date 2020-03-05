class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :phone_number
      t.string :cin
      t.string :gst
      t.string :pan
      t.string :url
      t.string :address
      t.integer :status, default: 0
      t.timestamps
    end
    add_reference :users, :organization, foreign_key: true
  end
end
