$:.unshift File.expand_path(File.dirname(File.expand_path(__FILE__)))
module BillApi
  module Workflow
  
    %w(base event state  transition  errors business_process).each do |base_req|
      require File.dirname(__FILE__) + "/workflow/#{base_req}"
    end

    %w(send_bill reject_bill view_bill approve_bill revoke_bill mark_paid_bill).each do |transition|
      require File.dirname(__FILE__) + "/workflow/transitions/#{transition}"
    end

    module ClassMethods
      
    end
    
    module InstanceMethods
      #
      #Create businessprocess , with filled data 
      #then after-create will be notify MQ-queue that we have one new BP, witch should be performed
      #
      def start(options = {})
        #todo validation for main optons
          bp = options[:klass].new(:workflow_id => self.id , :user_id => options[:user_id], :raw_workflow => options[:data] , :bill_id => options[:bill_id])
          bp.current_state = "created_state"
          bp.save!
      end

    end
    
    def self.included(receiver)
      raise NonPersistenseModel unless receiver.new.respond_to?(:raw_workflow)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
    end
  end
  
  
end

