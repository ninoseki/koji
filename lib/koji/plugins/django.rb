# frozen_string_literal: true

module Koji
  module Plugins
    class Django < Base
      def debug_toolbar
        # ref. https://github.com/jazzband/django-debug-toolbar
        website.doc&.at_css("#djDebug")
      end

      def evidence_list
        @evidence_list ||= [].tap do |out|
          out << "The website contains Django Debug Toolbar" if debug_toolbar
        end
      end

      def score
        evidence_list.empty? ? 0 : 100
      end
    end
  end
end
