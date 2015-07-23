class AddRepliesToPostsAndUsers < ActiveRecord::Migration
  def change
  	change_table :replies do |t|
  		t.belongs_to :user
  		t.belongs_to :post
  	end	
  end
end
