require "saver/version"

module Saver
  extend ActiveSupport::Concern

  included do
    @savers = {}

    before_save :save_savers
  end

  module ClassMethods
    def save_attribute(attribute, options = {})
      key "#{attribute}_saver", String
      @savers[attribute] = options[:method] || :to_s
    end
  end

  module InstanceMethods
    def save_savers
      @savers.each do |attribute, method|
        self.send("#{attribute}_saver=", self.send(attribute).send(method))
      end
    end
  end
end
