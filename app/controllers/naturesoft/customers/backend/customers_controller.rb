module Naturesoft
  module Customers
    module Backend
      class CustomersController < Naturesoft::Backend::BackendController
        before_action :set_customer, only: [:show, :edit, :update, :destroy]
        before_action :default_breadcrumb
        
        # add top breadcrumb
        def default_breadcrumb
          add_breadcrumb "Customers", naturesoft_customers.backend_customers_path
        end
    
        # GET /customers
        def index
          @customers = Customer.search(params).paginate(:page => params[:page], :per_page => 10)
        end
    
        # GET /customers/1
        def show
        end
    
        # GET /customers/new
        def new
          @customer = Customer.new
          add_breadcrumb "New Customer", nil,  class: "active"
        end
    
        # GET /customers/1/edit
        def edit
          add_breadcrumb "Edit Customer", nil,  class: "active"
        end
    
        # POST /customers
        def create
          @customer = Customer.new(customer_params)
    
          if @customer.save
            redirect_to naturesoft_customers.edit_backend_customer_path(@customer.id), notice: 'Customer was successfully created.'
          else
            render :new
          end
        end
    
        # PATCH/PUT /customers/1
        def update
          if @customer.update(customer_params)
            redirect_to naturesoft_customers.edit_backend_customer_path(@customer.id), notice: 'Customer was successfully updated.'
          else
            render :edit
          end
        end
    
        # DELETE /customers/1
        def destroy
          @customer.destroy
          render text: 'Customer was successfully destroyed.'
        end
    
        private
          # Use callbacks to share common setup or constraints between actions.
          def set_customer
            @customer = Customer.find(params[:id])
          end
    
          # Only allow a trusted parameter "white list" through.
          def customer_params
            params.fetch(:customer, {}).permit(:first_name, :last_name, :email, :phone, :address, :country_id, :area_id)
          end
      end
    end
  end
end
