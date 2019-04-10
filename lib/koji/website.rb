# frozen_string_literal: true

require "digest/sha2"
require "http"
require "oga"
require "uri"

module Koji
  class Website
    attr_reader :url

    def initialize(url)
      @url = URI(url)
    rescue URI::Error => _
      raise ArgumentError, "#{uri} is not a valid URL."
    end

    def response
      @response ||= get
    end

    def body
      @body ||= response ? response&.body&.to_s : nil
    end

    def sha256
      @sha256 ||= body ? Digest::SHA256.hexdigest(body.to_s) : nil
    end

    def doc
      @doc ||= body ? parse_html(body.to_s) : nil
    end

    def exception
      @exception || nil
    end

    private

    def get
      HTTP.get(url)
    rescue OpenSSL::SSL::SSLError, HTTP::Error, Addressable::URI::InvalidURIError => e
      @exception = e
      nil
    end

    def parse_html(html)
      Oga.parse_html(html)
    rescue ArgumentError, Encoding::CompatibilityError, LL::ParserError => _
      nil
    end
  end
end
