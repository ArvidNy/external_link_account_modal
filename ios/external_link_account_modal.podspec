#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint external_link_account_modal.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'external_link_account_modal'
  s.version          = '1.0.0'
  s.summary          = 'An easy-to-use widget that complies with Apple\'s External Link Account requirements for reader apps.'
  s.description      = <<-DESC
  An easy-to-use widget that complies with Apple's External Link Account requirements for reader apps.
                       DESC
  s.homepage         = 'https://github.com/ArvidNy/external_link_account_modal'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Arvid Nyström' => 'apps@arvidnystrom.se' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
