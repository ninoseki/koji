# frozen_string_literal: true

module Koji
  class Detector
    attr_reader :website

    def initialize(website)
      @website = website
    end

    def score
      plugins.map(&:score).sum
    end

    def verdict
      case score.to_i
      when -Float::INFINITY..49
        "Not underconstruction"
      when 50..99
        "Possibly underconstruction"
      when 100..Float::INFINITY
        "Underconstruction"
      end
    end

    def report
      {
        verdict: verdict,
        score: score
      }
    end

    def detailed_report
      plugin_reports = plugins.map(&:report).select { |report| report.dig(:score).to_i.positive? }
      report.merge(plugin_reports: plugin_reports)
    end

    private

    def plugins
      @plugins ||= Koji.plugins.map { |klass| klass.new website }
    end
  end
end
