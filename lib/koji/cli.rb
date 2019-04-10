# frozen_string_literal: true

require "thor"
require "json"

module Koji
  class CLI < Thor
    desc "check URL", "check a given URL"
    option :verbose, type: :boolean, default: false
    def check(url)
      website = Website.new(url)
      detector = Detector.new(website)
      verbose = options.dig("verbose") || false
      report = verbose ? detector.detailed_report : detector.report

      puts JSON.pretty_generate(report)
    end
  end
end
