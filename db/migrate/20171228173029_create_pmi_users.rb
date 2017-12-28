class CreatePmiUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :pmi_users do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :credential
      t.string :status
      t.datetime :earned

      t.timestamps
    end
  end
end
