#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "ZZAutoDescription"
  s.version          = File.read('VERSION')
  s.summary          = "Pretty-printer for your of standard Objective-C objects."
  s.description      = <<-DESC
  					   `ZZAutoDescription` is a convenient set of categories for pretty printing your own objects, and also standard objects and collections from Objective-C.
                       DESC
  s.homepage         = "https://github.com/ivanzoid/ZZAutoDescription"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ivan Zezyulya" => "ZZAutoDescription@zoid.cc" }
  s.source           = { :git => "https://github.com/ivanzoid/ZZAutoDescription.git", :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/EXAMPLE'

  s.platform     = :ios, '5.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  #s.resources = 'Assets/*.png'

  #s.ios.exclude_files = 'Classes/osx'
  #s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
