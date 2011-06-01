module BillApi
  module Logging
    class BillEventLogger
      def initialize
        
      end

      def publish(msg,obj,params = {})
        event = Event.new(:message => msg, :eventable_id => obj.id, :eventable_type => obj.class.to_s , :preferences => params)
        BillApi::BillQueue::Publisher.new.amqp_send("log-events" , event)
      end
    end
  end
end