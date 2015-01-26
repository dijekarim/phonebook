class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :more_phone
      t.references :contact, index: true

      t.timestamps null: false
    end
    add_foreign_key :phones, :contacts
  end
end
