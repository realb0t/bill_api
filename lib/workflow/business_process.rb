module BillApi
  module Workflow
    module BusinessProcess

      module ClassMethods
        
      end
  
      module InstanceMethods
        def start
          self.current_state = 'initialized_state'
          self.workflow_data.current_state = 'initialized_state'
          self.raw_workflow = self.workflow_data.persistanse_data
          self.save
          BillApi::BillQueue::Publisher.new.publish("workflow-initialized_state" , self)
        end
        def workflow_data
          @_workflow_data ||= BillApi::Workflow::Base.new(self.raw_workflow)
        end
      end
  
      def self.included(receiver)
        raise NonPersistenseModel unless receiver.new.respond_to?(:raw_workflow)
        receiver.extend         ClassMethods
        receiver.send :include, InstanceMethods
      end
    end
  end
end