class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :state
      t.string :country
      t.string :phone
      t.integer :relationship
      t.references :user

      t.timestamps
    end
  end
end
