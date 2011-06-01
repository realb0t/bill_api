module BillApi
  module BillQueue
    %w(helper publisher processor).each do |req_name|
      require File.dirname(__FILE__) + "/bill_queue/#{req_name}"
    end
  end
end