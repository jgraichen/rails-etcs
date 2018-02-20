# frozen_string_literal: true

module Rails
  module Etcs
    module VERSION
      MAJOR = 0
      MINOR = 1
      PATCH = 0
      STAGE = :beta1

      STRING = [MAJOR, MINOR, PATCH, STAGE].reject(&:nil?).join('.').freeze

      def self.to_s
        STRING
      end
    end
  end
end
