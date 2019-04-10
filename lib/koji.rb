# frozen_string_literal: true

require "mem"

module Koji
  class << self
    include Mem

    def plugins
      []
    end
    memoize :plugins
  end
end

require "koji/version"
require "koji/error"

require "koji/website"

require "koji/plugins/base"
require "koji/plugins/cakephp"
require "koji/plugins/codeigniter"
require "koji/plugins/django"
require "koji/plugins/domain"
require "koji/plugins/fuelphp"
require "koji/plugins/php_debugbar"
require "koji/plugins/phpinfo"
require "koji/plugins/self_signed_cert"
require "koji/plugins/symfony"

require "koji/detector"
require "koji/cli"
