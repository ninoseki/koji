# frozen_string_literal: true

RSpec.describe Koji::Plugins::CodeIgniter do
  include_context "with plugin"

  let(:body) { File.read File.expand_path("./../fixtures/codeigniter.html", __dir__) }

  before { stub_request(:get, "example.com").to_return(body: body, status: 200) }

  describe "#evidence_list" do
    it "returns an array (lenght == 1)" do
      expect(subject.evidence_list).to be_an(Array)
      expect(subject.evidence_list.length).to eq(1)
    end
  end
end
