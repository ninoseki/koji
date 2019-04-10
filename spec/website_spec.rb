# frozen_string_literal: true

RSpec.describe Koji::Website do
  subject { described_class.new url }

  let(:url) { "http://example.com" }
  let(:body) { "<html><title>test</title></htmL>" }

  before { stub_request(:get, "example.com").to_return(body: body, status: 200) }

  describe "#response" do
    it "returns a string" do
      expect(subject.response.body.to_s).to eq(body)
    end
  end
end
