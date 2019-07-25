# frozen_string_literal: true

module Koji
  module Plugins
    class PHPinfo < Base
      def title
        website.doc&.at_css("title")&.text == "phpinfo()"
      end

      def logo
        website.doc&.at_css('img[alt="PHP Logo"]')
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website contains phpinfo" if title || logo
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
