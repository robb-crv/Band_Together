class LinkAdvsToUser < ActiveRecord::Migration[5.0]
  def change
  	add_reference :advertisments, :user, index: true
  end
end
