#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ios_communication_notification.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ios_communication_notification'
  s.version          = '0.0.11'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://github.com/Iambiengcode'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Askany' => 'lambiengcode@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  # s.platform = :ios, '9.0'
  # s.ios.deployment_target = '10.0'
  # # Flutter.framework does not contain a i386 slice.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  # s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'
  s.static_framework = true
end
