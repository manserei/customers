require 'spec_helper'

describe "the customers index" do
  before do
    FactoryGirl.create_list(:customer, 10)
    visit "/customers"
  end

  it "displays a list of all customers" do
    Customer.all.each do |customer|
      page.should have_selector "td", text: customer.full_name
    end
  end
end
