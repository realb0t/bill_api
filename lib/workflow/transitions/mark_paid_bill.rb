module BillApi
  module Workflow
    class MarkPaidBill < Transition
      def perform
        @bill = Bill.find(@workflow.bill_id)
        @bill.mark_paid
        @bill.events.create(:message =>"#{@workflow.initiator_email} пометил счет как оплаченный")
        @bill.comments.create(:body => @params["comment"],:base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        Notifier.deliver_mark_as_paid(:bill => @bill, :comment => @params["comment"] , :base_contact => @workflow.initiator_email)
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end