# frozen_string_literal: true

class BaseForm
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  def initialize; end

  class << self
    def attr_accessor(*args)
      @attributes ||= []
      @attributes.concat(args)

      super
    end

    attr_reader :attributes
  end
end
