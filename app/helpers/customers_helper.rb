module CustomersHelper
  def foo
    'bar'
  end

  def customer_photo(customer)
    image_tag('http://placekitten.com/100/80')
  end
end
