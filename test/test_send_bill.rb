require 'helper'

class TestWorkflowDefinition < Test::Unit::TestCase
  context "construct_from_json" do
    
     setup do
         @bill = Bill.create(:base_contact => 'talala@mail.ru')
         @json_str ="{'name' : 'send_workflow' , 'data' :  {
         'bill_id' : #{@bill.id},
         'current_state': 'created_state',
         'initiator_email' : #{@bill.base_contact},
         'action_token' : '1',
         'action_id' : '2',
         'states' : [
         			{'1' : 'created_state'},
         			{'2' : 'send_state'}
         ],
         'transactions' : [
         		{
         			'name' : 'send_bill' ,
         			'from_state' : 'created_state' ,
         			'to_state' : 'sended_state' ,
         			'on_raise' : '1',
         			'params' : { 'recipient_email' : 'vasya_pupkin@gmail.com' }
         		}
         	]
         }
         }"
         @workflow = BillApi::Workflow::Base.construct(@json_str)
     end
 
     should "should find callable transitions" do
       assert !@workflow.transitions.empty?
       assert @workflow.transitions.size == 1
       assert @workflow.transitions[0] == @workflow.callable_transition
     end

   end

end



