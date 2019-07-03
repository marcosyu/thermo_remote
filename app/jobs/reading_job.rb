class ReadingJob < ActiveJob::Base
  @queue = :reading_job

  def self.perform(readings)
    Reading.transaction do
      Reading.import readings, validate: false
    end

  rescue ActiveModel::Errors => e
    puts "An occurred: #{e.errors.full_messages}"
    raise
  end
end
