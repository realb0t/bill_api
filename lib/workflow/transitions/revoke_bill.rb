module BillApi
  module Workflow
    class RevokeBill < Transition
      
      def perform
        @bill = Bill.find(@workflow.bill_id)
        @bill.revoke
        @bill.events.create(:message =>"#{@bill.sender} отозвал счет") 
        @bill.comments.create(:body => @params["comment"],:base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        Notifier.deliver_revoke_bill(:bill => @bill , :comment => @params["comment"])
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end