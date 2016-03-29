class CreateUserPhotos < ActiveRecord::Migration
  def change
    create_table :user_photos do |t|
      t.references :user, index: true, foreign_key: true
      t.references :photo, index: true, foreign_key: true
    end
  end
end
