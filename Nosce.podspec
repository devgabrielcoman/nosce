# Be sure to run `pod lib lint Nosce.podspec' to ensure this is a

Pod::Spec.new do |s|
  s.name             = "Nosce"
  s.version          = "0.1.9"
  s.summary          = "Nosce - print your models"
  s.description      = <<-DESC
                       Nosce is a swift utility library that prints out the insides of model type objects
                       DESC

  s.homepage         = "https://github.com/devgabrielcoman/nosce"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => "GPL v3", :file => "LICENSE" }
  s.author           = { "Gabriel Coman" => "dev.gabriel.coman@gmail.com" }
  s.source           = { :git => "https://github.com/devgabrielcoman/nosce.git", :branch => "master", :tag => "0.1.9" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/*'
  s.resource_bundles = {
    'Nosce' => ['Pod/Assets/*.png']
  }
end
