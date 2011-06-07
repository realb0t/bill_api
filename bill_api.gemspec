Gem::Specification.new do |s|
  s.name = %q{bill_api}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dieinzige"]
  s.date = %q{2010-01-01}
  s.description = %q{}
  s.email = %q{dieinzige@gvfs.ru}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/bill_api.rb",
     "lib/bill_queue.rb",
     "lib/bill_queue/helper.rb",
     "lib/bill_queue/processor.rb",
     "lib/bill_queue/publisher.rb",
     "lib/logging.rb",
     "lib/logging/bill_event_logger.rb",
     "lib/logging/bill_logger.rb",
     "lib/workflow.rb",
     "lib/workflow/base.rb",
     "lib/workflow/business_process.rb",
     "lib/workflow/errors.rb",
     "lib/workflow/event.rb",
     "lib/workflow/event/approve_event.rb",
     "lib/workflow/event/send_event.rb",
     "lib/workflow/event/view_event.rb",
     "lib/workflow/state.rb",
     "lib/workflow/state/completed_state.rb",
     "lib/workflow/state/confirmation_state.rb",
     "lib/workflow/state/pause_state.rb",
     "lib/workflow/state/running_state.rb",
     "lib/workflow/transition.rb",
     "lib/workflow/transition/approve_bill.rb",
     "lib/workflow/transition/mark_paid_bill.rb",
     "lib/workflow/transition/reject_bill.rb",
     "lib/workflow/transition/revoke_bill.rb",
     "lib/workflow/transition/send_bill.rb",
     "lib/workflow/transition/view_bill.rb",
     "test/helper.rb",
     "test/test_BillApi.rb",
     "test/test_send_bill.rb"
  ]
  s.homepage = %q{http://gvfs.ru/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{}
  s.test_files = [
    "test/helper.rb",
    "test/test_BillApi.rb",
    "test/test_send_bill.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
