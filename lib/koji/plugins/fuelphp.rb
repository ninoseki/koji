# frozen_string_literal: true

module Koji
  module Plugins
    class FuelPHP < Base
      def profiler
        website.doc&.at_css("#openProfiler > a")
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website contains FuelPHP's Profiler" if profiler
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
