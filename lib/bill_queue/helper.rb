module BillApi
  module BillQueue
    module Helper
      def log message
        puts "#{MQ.id}: #{message}"
      end

      def logp *args
        print args
        $stdout.flush
      end

      def graceful_death
        AMQP.stop{ EM.stop }
        exit(0)
      end

      protected

      def load_rails_environment
       # require 'config/environment' #TODO rewrite for load rails env
      end



      def serialize data
        Marshal.dump(data)
      end

      def unserialize data
        autoload_missing_constants do
          Marshal.load data
        end
      end

      def autoload_missing_constants
        yield
      rescue ArgumentError => error
        lazy_load ||= Hash.new {|hash, hash_key| hash[hash_key] = true; false}
        if error.to_s[/undefined class|referred/] && !lazy_load[error.to_s.split.last.constantize]
          retry
        else
          raise error
        end
      end
    end
  end
end