class ChangeCharityToStudio < ActiveRecord::Migration
  def change
    rename_table :charities, :studios
    remove_column :studios, :logo
    add_column :studios, :status, :integer
  end
end
