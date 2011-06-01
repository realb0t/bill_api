module BillApi
  module BillQueue
    class Publisher
      include BillApi::BillQueue::Helper
      def initialize
        load_rails_environment
      end
      
      #Call process on selected queue
      def publish(queue_name, object)
          amq = MQ.new
          amq.queue(queue_name).publish(serialize(object))
      end # end run process
      
      def amqp_send(queue_name, object)
        AMQP.start do
           amq = MQ.new
          amq.queue(queue_name).publish(serialize(object))
          AMQP.stop { EM.stop }
        end
      end
    end
  end
end