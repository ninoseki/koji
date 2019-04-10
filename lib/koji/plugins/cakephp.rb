# frozen_string_literal: true

module Koji
  module Plugins
    class CakePHP < Base
      def debug_toolbar
        website.body&.to_s&.include?("js_debug_toolbar.js") && website.body&.to_s&.include?("debug_toolbar.css")
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website contains CakePHP's debug toolbar" if debug_toolbar
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
