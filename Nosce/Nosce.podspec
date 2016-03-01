#
# Be sure to run `pod lib lint Nosce.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Nosce"
  s.version          = "0.1.0"
  s.summary          = "Nosce is a swift utility library that prints out the insides of model type objects"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/devgabrielcoman/nosce"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'https://github.com/devgabrielcoman/nosce/blob/master/LICENSE'
  s.author           = { "Gabriel Coman" => "dev.gabriel.coman@gmail.com" }
  s.source           = { :git => "https://github.com/devgabrielcoman/nosce.git", :branch => "master" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Nosce' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Dollar'
end
