# frozen_string_literal: true

module Koji
  module Plugins
    class SelfSignedCertificate < Base
      def self_signed?
        website.body
        website.exception.is_a?(OpenSSL::SSL::SSLError) && website.exception.to_s.include?("self signed certificate")
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website has a self-signed certificate" if self_signed?
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
