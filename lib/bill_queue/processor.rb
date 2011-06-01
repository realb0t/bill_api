module BillApi
  module BillQueue
    class Processor
     include BillApi::BillQueue::Helper
      def initialize
        load_rails_environment
      end
      
      #Call process on selected queue
      def run_process(queue, &block)
        queue.subscribe(:ack => true) { |headers, payload|
          data = unserialize(payload)
          block.call(data)
          headers.ack
        }
      end # end run process
    end
  end
end
