Pod::Spec.new do |s|
  s.name             = "Glassfy"
  s.version          = "1.4.0-beta.0"
  s.summary          = "Subscription and in-app-purchase service."
  s.license          =  { :type => 'MIT', :file => 'LICENSE' }
  s.source           = { :git => "https://github.com/glassfy/ios-sdk.git", :tag => s.version.to_s }
  s.homepage         = "https://glassfy.io/"
  s.author           = { "Glassfy" => "support@glassfy.io" }
  s.framework        = 'StoreKit'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.15'

  s.source_files = 'Source/Public/*.h', 'Source/*.{h,m}'
  s.public_header_files = 'Source/Public/*.h'
  
  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'Tests/*.{h,m,swift}'
      test_spec.resource = 'Tests/*.{json}'
  end
end
