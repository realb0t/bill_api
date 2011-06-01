module BillApi
  module Workflow
    class Transition
      attr_accessor :from_state , :to_state, :on_raise , :name , :params , :workflow
      
      def initialize(workflow,options = {})
        @from_state = options["from_state"]
        @to_state = options["to_state"]
        @on_raise = options["on_raise"]
        @name = options["name"]
        @params = options["params"]
        @workflow = workflow
      end
      
      def can_perform
        user.is_holder?(bill) && token_valid?
      end
      
      def perform
        raise "Should be override to perform"
      end
      
      def user
        
      end
      
      def bill
        
      end

      protected
        def token_valid?
          unless require_token?
            action = Action.find_by_id_and_token(action_id,action_token)
            return !action.nil?
          end
          true
        end
      
        def require_token?
          raise "Should be Override in real Transactions"
        end
    end
  end
end