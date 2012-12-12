class Project < ActiveRecord::Base
  attr_accessible :description, :title, :customer_id
  validates_presence_of :customer_id

  belongs_to :customer
end
