require 'rubygems'
require 'json'
module BillApi
  module Workflow
    class Base
      attr_accessor :attributes
      attr_accessor :bill_id
      def self.construct(json_obj)
        Base.new(json_obj)
      end
      
      def initialize(base_obj)
         @raw_obj  = base_obj
         @attributes = {}
         @transitions = []
         call_parser_stack
      end
      
      def bill_id
        @bill_id || @attributes["data"]["bill_id"]
      end
      
      def bill_id=(v)
        @attributes["data"]["bill_id"] = v
      end
      
      
      def initiator_email=(v)
        @attributes["data"]["initiator_email"] = v
      end
      
      def initiator_email
         @attributes["data"]["initiator_email"]
      end
      

      
      #Get all states in ordered position
      def states
        @attributes["data"]["states"]
      end
      
      #Return current state
      def current_state
        @attributes["data"]["current_state"]
      end
      
      def current_state=(v)
        @attributes["data"]["current_state"] = v
      end
      
      def transaction_params(transaction_name , params)
        @attributes["data"]["transactions"].each do |t|
          t["params"] = params if t["name"] = transaction_name
        end 
      end
      
      def next_state
          
      end
      
      def transitions
         @transitions
      end
      
      def callable_transition
        @transitions.detect{|t| t.from_state == current_state }
      end
      
      def error_perform
        
      end
      
      #call event on current state
      #only if event can be trigged
      def trigger_event(event)
        event.watch(self) if can_trigged?(event)
      end
      
      #Validate can be event triggered
      def can_trigged?(event)
        false
      end
      
      #Transform current state of object to json format
      #define last - states,current-state,and future states
      #and events wich will call transictions
      #each event have a name - specified by user
      # for more doc : wiki/Workflow/Base.class
      def persist
        
      end
      
      #
      #Return current business process data as json
      #
      def persistanse_data
        @attributes.to_json
      end
      
      def call_parser_stack
        @attributes = ActiveSupport::JSON.decode(@raw_obj)
        @attributes["data"]["transactions"].each do |t|
          @transitions << "BillApi::Workflow::#{t["name"].camelize}".constantize.new(self,t)
        end
      end
      
    

    end
  end
end
