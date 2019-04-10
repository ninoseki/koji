# frozen_string_literal: true

RSpec.shared_context "with plugin" do
  subject { described_class.new website }

  let(:url) { "http://example.com" }
  let(:website) { Koji::Website.new url }

  context "when given a website with an empty HTML" do
    subject { described_class.new website }

    let(:url) { "http://example.com" }
    let(:body) { "<html></html>" }

    before { stub_request(:get, "example.com").to_return(body: body, status: 200) }

    describe "#evidence_list" do
      it "returns an empty array" do
        expect(subject.evidence_list).to be_an(Array)
        expect(subject.evidence_list.empty?).to eq(true)
      end
    end
  end
end
