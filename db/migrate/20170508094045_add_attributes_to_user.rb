class AddAttributesToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :username, :string
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :birth, :date
  	add_column :users, :type_of_musician, :string
  	add_column :users, :musical_genre, :string
  	add_column :users, :nation, :string
  	add_column :users, :region, :string
  	add_column :users, :gender, :string
  	add_column :users, :provider, :string
  	add_column :users, :uid, :string
  end
end
