module BillApi
  module Workflow
    class RejectBill < Transition
      
      def perform
        @bill = Bill.find(@workflow.bill_id)
        @bill.reject
        @bill.events.create(:message =>"#{@workflow.initiator_email} отказался оплачивать") 
        @bill.comments.create(:body => @params["comment"],:base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        Notifier.deliver_reject_bill(:bill => @bill , :comment => @params["comment"])
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end