# frozen_string_literal: true

RSpec.describe Koji do
  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
    described_class.plugins.each { |plugin| plugin.new Koji::Website.new("https://neverssl.com") }
  end

  describe ".plugins" do
    it "returns an array" do
      expect(described_class.plugins).to be_an(Array)
      expect(described_class.plugins.length).to be > 0
      described_class.plugins.each do |plugin|
        expect(plugin.superclass).to eq(described_class::Plugins::Base)
      end
    end
  end
end
