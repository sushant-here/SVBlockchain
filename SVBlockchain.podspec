#
# Be sure to run `pod lib lint SVBlockchain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SVBlockchain'
  s.version          = '1.2.0'
  s.summary          = 'Blockchain account balance querying for iOS apps!'

  s.description      = <<-DESC
    Async blockchain account balance querying for iOS apps!
    Supported coins:
    - Bitcoin
    - Litecoin
    - Etherium
    - Etherium Classic
    - Ripple
    - Bitcoin Cash
    
    Uses various external/3rd party APIs. Future release will provide validation and API disclaimer information.
                       DESC

  s.homepage         = 'https://github.com/sushant40/SVBlockchain'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sushant Verma' => 'sushant.40@gmail.com' }
  s.source           = { :git => 'https://github.com/sushant40/SVBlockchain.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'SVBlockchain/Classes/**/*'
  
  s.dependency 'SwiftyJSON', '~> 4.2'
  s.dependency 'CrossroadRegex', '~> 1.1.0'
end
