require "newsly/engine"
require "resque"
require "liquid"
require "resque-async_deliver"

module Newsly

  mattr_accessor :test_data, :resource_email_column, :recipient_groups, :default_from, :return_path
  @@test_data = {}
  @@recipient_groups = {}
  @@resource_email_column = :email
  @@default_from = "changethis@newsly.com"
  @@return_path = "changethis@newsly.com"

  def self.setup
    yield self
  end

  def self.define_newsletter_receipient_group(group, &block)
    @@recipient_groups[group] = block
  end

  def self.get_newsletter_receipient_group(group)
    @@recipient_groups[group]
  end

end
