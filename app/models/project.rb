class Project < ActiveRecord::Base
  attr_accessible :description, :title, :customer_id
  validates_presence_of :customer_id, :title

  belongs_to :customer

  validate do
    if customer.reached_project_limit?
      errors.add(:customer, "has reached project limit")
    end
  end
end
