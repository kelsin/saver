require "saver/version"
require "active_support"

module Saver
  extend ActiveSupport::Concern

  included do
    before_save :save_savers
  end

  module ClassMethods
    def save_attributes(*attributes)
      attributes.each do |attr|
        save_attribute(attr)
      end
    end

    def save_attribute(attribute, options = {})
      key "#{attribute}_saver", String
      self.savers[attribute] = options[:method] || :to_s
    end

    def savers
      @savers ||= {}
    end
  end

  module InstanceMethods
    def save_savers
      self.class.savers.each do |attribute, method|
        self.send("#{attribute}_saver=", self.send(attribute).send(method))
      end
    end
  end
end
