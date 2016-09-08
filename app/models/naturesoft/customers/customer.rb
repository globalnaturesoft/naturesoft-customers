module Naturesoft::Customers
  class Customer < ApplicationRecord
    if Naturesoft::Core.available?("areas")
      belongs_to :country, class_name: "Naturesoft::Areas::Country"
      belongs_to :area, class_name: "Naturesoft::Areas::Area"
    end
    
    def self.sort_by
      [
        ["First Name","naturesoft_customers_customers.first_name"],
        ["Last Name","naturesoft_customers_customers.last_name"],
        ["Created At","naturesoft_customers_customers.created_at"],
      ]
    end
    
    def self.sort_orders
      [
        ["ASC","asc"],
        ["DESC","desc"]
      ]
    end
    
    def self.status
      [
        ["All",""],
        ["Active","true"],
        ["Inactive","false"]
      ]
    end
    
    #Filter, Sort
    def self.search(params)
      records = self.all
      
      #Search keyword filter
      if params[:keyword].present?
        params[:keyword].split(" ").each do |k|
          records = records.where("LOWER(CONCAT(naturesoft_customers_customers.first_name,' ',naturesoft_customers_customers.last_name,' ',naturesoft_customers_customers.email,' ',naturesoft_customers_customers.phone,' ',naturesoft_customers_customers.address)) LIKE ?", "%#{k.strip.downcase}%") if k.strip.present?
        end
      end
      
      # for sorting
      sort_by = params[:sort_by].present? ? params[:sort_by] : "naturesoft_customers_customers.first_name"
      sort_orders = params[:sort_orders].present? ? params[:sort_orders] : "asc"
      records = records.order("#{sort_by} #{sort_orders}")
      
      return records
    end
    
    # display full name for customer
    def full_name
      if first_name.present? and last_name.present?
        name = first_name + ' ' + last_name
      elsif first_name.present? and !last_name.present?
        name = first_name
      elsif !first_name.present? and last_name.present?
        name = last_name
      end
      return name
    end
    
  end
end
