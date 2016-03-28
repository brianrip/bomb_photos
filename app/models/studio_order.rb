class StudioOrder < ActiveRecord::Base
  belongs_to :studio
  belongs_to :order
end
