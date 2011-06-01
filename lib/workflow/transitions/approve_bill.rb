module BillApi
  module Workflow
    class ApproveBill < Transition
      
      def perform
        @bill = Bill.find(@workflow.bill_id)
        @bill.comments.create(:body => @params["comment"], :base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        @emails  = @params["recipient_emails"]
        @bill.events.create(:message =>"#{@workflow.initiator_email} переслал для визирования #{@emails.join(" , ")}")
        @emails.each do |e|
           permission = ApproverPermission.create(:bill_id => @bill.id , :base_contact => e )
           Notifier.deliver_approve_bill(:bill => @bill, :permission => permission , :comment => @params["comment"] )
        end
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end