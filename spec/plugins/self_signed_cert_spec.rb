# frozen_string_literal: true

RSpec.describe Koji::Plugins::SelfSignedCertificate do
  include_context "with plugin"

  let(:body) { "" }

  before {
    stub_request(:any, "example.com").
      to_raise(
        OpenSSL::SSL::SSLError.new(
          "SSL_connect returned=1 errno=0 state=error: certificate verify failed (self signed certificate)"
        )
      )
  }

  describe "#evidence_list" do
    it "returns an array (lenght == 1)" do
      expect(subject.evidence_list).to be_an(Array)
      expect(subject.evidence_list.length).to eq(1)
    end
  end
end
