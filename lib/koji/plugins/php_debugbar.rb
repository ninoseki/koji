# frozen_string_literal: true

module Koji
  module Plugins
    class PHPDebugBar < Base
      def js_debug_bar
        website.body&.to_s&.include? "var phpdebugbar = new PhpDebugBar.DebugBar()"
      end

      def debug_bar
        website.body&.to_s&.include?("debugbar/debugbar.js") && website.body&.to_s&.include?("debugbar/debugbar.css")
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website contains PHP DebugBar" if debug_bar || js_debug_bar
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
