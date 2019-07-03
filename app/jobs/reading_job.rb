class ReadingJob < ActiveJob::Base
  @queue = :reading_job

  def self.perform(args = {})
    Reading.create(args[:params])
    cache = ActiveSupport::Cache::MemoryStore.new
    cache.delete(args[:token])
  end

end
