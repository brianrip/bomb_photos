class OrderPhoto < ActiveRecord::Base
  belongs_to :order
  belongs_to :photo
end
