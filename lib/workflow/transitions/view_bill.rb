module BillApi
  module Workflow
    class ViewBill < Transition
      
      def perform
        @bill = Bill.find(@workflow.bill_id)
        permission = ViewerPermission.create!(:bill_id => @bill.id, :base_contact => @params["recipient_email"])
        Notifier.deliver_view_bill(:bill => @bill,:permission => permission, :comment => @params["comment"])
        @bill.events.create(:message =>"#{@workflow.initiator_email } переслал счет для просмотра #{@params["recipient_email"]}") 
        @bill.comments.create(:body => @params["comment"],:base_contact => @workflow.initiator_email) unless @params["comment"].blank?
        @workflow.current_state = @params["to_state"]
      end
      
      def require_token?
        false
      end
    end
  end
end