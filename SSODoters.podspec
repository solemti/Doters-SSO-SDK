#
# Be sure to run `pod lib lint SSODoters.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SSODoters'
  s.version          = '1.4.13'
  s.summary          = 'Single Sign On Doters.'
  s.swift_versions          = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Doters Single Sign On SDK. '

  s.homepage         = 'https://github.com/solemti/Doters-SSO-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alejandro' => 'alejandrosoto@solemti.mx' }
  s.source           = { :git => 'https://github.com/solemti/Doters-SSO-SDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'SSODoters/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SSODoters' => ['SSODoters/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
