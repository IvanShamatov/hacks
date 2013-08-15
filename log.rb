# encoding: utf-8

class Log < ActiveRecord::Base

  # Methods
  #  #info, #debug, #error, #critical
  #
  # Usage:
  #
  # Log.info("test") => will generate sidekiq job to do
  #    Log.create(:level => :info, :message => "#{Timestamp} [INFO]: test")
  #
  # Log.debug("test2", AppletInstance.first.id) #=>
  #    asynchronosly:
  #    Log.create(:level => :debug,
  #               :message => "2013-07-24 18:50:43 +0400 [DEBUG]: test")
  #
  # All ActiveRecord requests works as previous


  include Sidekiq::Worker
  after_initialize :format_message

  # Creating 4 class methods to call Log's
  class << self
    [:info, :debug, :error, :critical].each do |level|
      define_method level do |message, *args|
        self.perform_async(message, level, *args)
      end
    end
  end


  # formatting message
  def format_message(level, message)
    "#{Time.now} [#{level.upcase}]: #{message}"
  end


  # Performing a job
  def perform(message, level, *args)
    log = new(message, level, *args)
    log.save
  end

end
