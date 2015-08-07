Pod::Spec.new do |s|
  s.name = 'MoneyTextField'
  s.version = '0.0.1'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'UITextField with ATM-style editing'
  s.homepage = 'https://github.com/adamhartford/MoneyTextField'
  s.social_media_url = 'http://twitter.com/adamhartford'
  s.authors = { 'Adam Hartford' => 'adam@adamhartford.com' }
  s.source = { :git => 'https://github.com/adamhartford/MoneyTextField.git', :tag => "v#{s.version}" }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MoneyTextField.swift'

  s.requires_arc = true
end
