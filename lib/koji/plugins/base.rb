# frozen_string_literal: true

module Koji
  module Plugins
    class Base
      def self.inherited(child)
        Koji.plugins << child
      end

      attr_reader :website

      def initialize(website)
        @website = website
      end

      def evidence_list
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def score
        raise NotImplementedError, "You must implement #{self.class}##{__method__}"
      end

      def name
        self.class.to_s.split("::").last
      end

      def report
        {
          name: name,
          evidence_list: evidence_list,
          score: score
        }
      end
    end
  end
end
