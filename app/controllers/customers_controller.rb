class CustomersController < InheritedResources::Base
  before_filter :load_customer, :only => [:show, :edit, :update, :destroy]
  skip_before_filter :force_login, :only => [:show]
  respond_to :html, :xml, :json

  def load_customer
    @customer = Customer.find(params[:id])
  end

  def index
    @customers = Customer.all
    respond_with(@customers)
  end

  def show
    respond_with(@customer, :include => { :projects => { :except => :customer_id }},
      :except => :email)
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  def new
    @customer = Customer.new
    respond_with @customer
  end

  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      respond_with(@customer) do |format|
        format.html { redirect_to customers_path }
      end
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @customer.update_attributes(params[:customer])
      respond_with @customer
    else
      render :action => 'edit'
    end
  end
end
