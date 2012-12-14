require 'spec_helper'

describe "the customers index" do
  before do
    FactoryGirl.create_list(:customer, 10)
    visit "/customers"
  end

  it "displays a list of all customers", js: true do
    Customer.count.should == 10

    page.should have_selector 'h1', text: 'List of all customers'

    Customer.all.each do |customer|
      page.should have_selector "td", text: customer.full_name
    end
  end
end
