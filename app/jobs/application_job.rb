class ApplicationJob < ActiveJob::Base
  queue_as :thermo_remote
end
