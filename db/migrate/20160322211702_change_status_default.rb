class ChangeStatusDefault < ActiveRecord::Migration
  def change
    change_column :photos, :active, :boolean, default: true
  end
end
