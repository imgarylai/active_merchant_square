# frozen_string_literal: true

require_relative 'lib/active_merchant_square/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_merchant_square'
  spec.version       = ActiveMerchantSquare::VERSION
  spec.authors       = ['Gary Lai']
  spec.email         = ['garylai1990@gmail.com']

  spec.summary       = 'Active Merchant for Square'
  spec.description   = 'Active Merchant for Square'
  spec.homepage      = 'https://github.com/machiyami/active_merchant_square'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/machiyami/active_merchant_square'
  spec.metadata['changelog_uri'] = 'https://github.com/machiyami/active_merchant_square/blob/master/CHANGELOG'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
