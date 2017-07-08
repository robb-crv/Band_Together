class AddTypeToJoinRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :join_requests, :req_type, :string
  end
end
