# frozen_string_literal: true

class BaseService
  attr_accessor :params

  def initialize(params)
    @params = params.respond_to?(:to_unsafe_hash) ? params.to_unsafe_hash : params
  end

  def self.call(*args, &block)
    new(*args, &block).call
  end
end
