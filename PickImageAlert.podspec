Pod::Spec.new do |s|
  s.name               = "PickImageAlert"
  s.version            = "1.0.1"
  s.summary            = "Photos or camera access using the system alert controller"
  s.description        = "PickImageAlert provides a list of your photos in your alert controller with three alert actions"
  s.requires_arc       = true
  s.homepage           = "https://github.com/limadeveloper/PickImageAlert"
  s.license            = "MIT"
  s.author             = { "John Lima" => "john.limadeveloper@icloud.com" }
  s.social_media_url   = "https://twitter.com/johncarloslima"
  s.platform           = :ios, "11.0"
  s.source             = { :git => "https://github.com/limadeveloper/PickImageAlert.git", :tag => "#{s.version}" }
  s.framework          = "UIKit"
  s.source_files       = "Framework/PickImageAlert/**/*.{swift}"
  s.resources          = "Framework/PickImageAlert/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
  s.swift_version      = "4.2"
end