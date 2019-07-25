# frozen_string_literal: true

require "public_suffix"

module Koji
  module Plugins
    class Domain < Base
      SUSPICIOUS_WORDS = %w(dev development stg staging test testing).freeze

      def domain
        @domain ||= PublicSuffix.parse(website.url.hostname)
      end

      def evidence_list
        @evidence_list ||= domain.trd.to_s.split(".").map do |part|
          "#{domain} contains a suspicious keyword: #{part}." if SUSPICIOUS_WORDS.include?(part)
        end.compact
      end

      def score
        evidence_list.empty? ? 0 : 50
      end
    end
  end
end
