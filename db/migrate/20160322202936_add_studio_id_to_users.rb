class AddStudioIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :studio, index: true, foreign_key: true
  end
end
