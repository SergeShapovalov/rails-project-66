class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, precision: true, null: false
      t.string :nickname
      t.string :token

      t.timestamps
    end
  end
end
