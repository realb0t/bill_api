module BillApi
  module Logging
    %w(bill_event_logger bill_logger).each do |base_req|
       require File.dirname(__FILE__) + "/logging/#{base_req}"
     end
  end
end