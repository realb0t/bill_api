require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'bill_api'
require 'active_record'
gem 'sqlite3-ruby'

ActiveRecord::Base.logger = Logger.new('/tmp/workflow.log')
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/workflows.sqlite')
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.default_timezone = :utc if Time.zone.nil?

ActiveRecord::Schema.define do

create_table :workflow, :force => true do |t|
    t.string :name
    t.string :description
    t.text   :raw_workflow
    t.timestamp :deleted_at, :default => nil
end

create_table :business_process, :force => true do |t|
  t.string    :current_state , :limit => 200
  t.text      :raw_workflow
  t.integer   :bill_id
end
create_table :bills, :force => true do |t|
  t.string    :base_contact , :limit => 200
  t.string    :state
end
create_table :permissions, :force => true do |t|
  t.string    :type , :limit => 200
  t.string    :base_contact
  t.text      :bill_id
end
create_table :workflows, :force => true do |t|
  t.string    :name
  t.string    :description
  t.reference :user
  t.text      :raw_workflow
  t.timestamps
end
create_table :business_processes,  :force => true do |t|
  t.timestamp :deleted_at, :default => nil
  t.string    :current_state , :limit => 200
  t.text      :raw_workflow
  t.reference :workflow
  t.reference :bill
  t.timestamps
end

end
class Bill < ActiveRecord::Base
  has_many :permissions

  def holder
    permissions.detect {|p| p.is_a?(HolderPermission)}
  end

  def holders
    permissions.select {|p| p.is_a?(HolderPermission)}
  end
end

class Permission < ActiveRecord::Base 
  belongs_to :bill
end

class HolderPermission < Permission

end

class ViewPermission < Permission

end

class ApprovePermission < Permission

end

class Workflow < ActiveRecord::Base
  has_many :business_process
  belongs_to :user
  include BillApi::Workflow
end

class BusinessProcess < ActiveRecord::Base
  belongs_to :bill
  belongs_to :workflow
  include BillApi::Workflow::BusinessProcess
end

class Test::Unit::TestCase
end
