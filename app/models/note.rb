class Note < ActiveRecord::Base
  attr_accessible :customer_id, :text
  belongs_to :customer
end
