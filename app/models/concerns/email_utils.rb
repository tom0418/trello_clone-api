# frozen_string_literal: true

module EmailUtils
  EMAIL_REGEX = /\A([^@\s])+@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze
end
