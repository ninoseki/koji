# frozen_string_literal: true

RSpec.describe Koji::Detector do
  context "when given a website" do
    subject { described_class.new website }

    let(:url) { "http://example.com" }
    let(:website) { Koji::Website.new url }
    let(:body) { "" }

    before { stub_request(:get, "example.com").to_return(body: body, status: 200) }

    describe "#report" do
      it "returns a hash" do
        expect(subject.report).to be_a(Hash)
        score = subject.report.dig(:score)
        expect(score).to eq(0)
        verdict = subject.report.dig(:verdict)
        expect(verdict).to eq("Not underconstruction")
      end
    end
  end

  context "when given a dev env website" do
    subject { described_class.new website }

    let(:url) { "http://dev.example.com" }
    let(:website) { Koji::Website.new url }
    let(:body) { File.read File.expand_path("./fixtures/phpinfo.html", __dir__) }

    before { stub_request(:get, "dev.example.com").to_return(body: body, status: 200) }

    describe "#report" do
      it "returns a hash" do
        expect(subject.report).to be_a(Hash)
        score = subject.report.dig(:score)
        expect(score).to be > 0
        verdict = subject.report.dig(:verdict)
        expect(verdict).to eq("Underconstruction")
      end
    end
  end
end
