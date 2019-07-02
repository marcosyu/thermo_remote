class ReadingJob < ApplicationJob

  def self.perform(reading)
    reading = Reading.create(reading)

  rescue ActiveModel::Errors => e
    puts "An occurred: #{e.errors.full_messages}"
    raise
  end
end
