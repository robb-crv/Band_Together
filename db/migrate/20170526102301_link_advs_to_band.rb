class LinkAdvsToBand < ActiveRecord::Migration[5.0]
  def change
  	add_reference :advertisments, :band, index: true
  end
end
