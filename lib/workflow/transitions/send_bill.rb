module BillApi
  module Workflow
    class SendBill < Transition
      
      def perform
        @bill = Bill.find(@workflow.bill_id)
        current_token = @bill.holder_permission.token
        HolderPermission.delete_all(:bill_id => @bill.id)
        ViewerPermission.create!(:bill_id => @bill.id, :base_contact => @workflow.initiator_email , :token => current_token)
        permission = HolderPermission.create!(:bill_id => @bill.id, :base_contact => @params["recipient_email"])
        @bill.events.create(:message =>"#{@workflow.initiator_email } переслал счет #{@params["recipient_email"]}") 
        Notifier.deliver_forwarding_bill(:bill => @bill, :permission => permission , :comment =>@params["comment"] )
        @bill.comments.create(:body => @params["comment"],:base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end