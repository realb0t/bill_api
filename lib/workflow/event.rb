module BillApi
  module Workflow
    class Event
      attr_accessor :last, :action_hash
      alias_method :last?, :last
      
      
    end
  end
end