Pod::Spec.new do |s|
  s.name             = "ZZAutoDescription"
  s.version          = '1.0.2'
  s.summary          = "Pretty-printer for your or standard Objective-C objects."
  s.description      = <<-DESC
  					   `ZZAutoDescription` is a convenient set of categories for pretty printing your own objects, and also standard objects and collections from Objective-C.
                       DESC
  s.homepage         = "https://github.com/ivanzoid/ZZAutoDescription"
  s.license          = 'MIT'
  s.author           = { "Ivan Zezyulya" => "ZZAutoDescription@zoid.cc" }
  s.source           = { :git => "https://github.com/ivanzoid/ZZAutoDescription.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.requires_arc = true
  s.source_files = 'Source'
end
