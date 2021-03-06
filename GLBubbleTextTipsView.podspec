#
# Be sure to run `pod lib lint GLBubbleTextTipsView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLBubbleTextTipsView'
  s.version          = '0.1.1'
  s.summary          = '气泡引导提示视图'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  气泡引导提示视图，无需重复造轮子，有需要的可以直接拿走...
                       DESC

  s.homepage         = 'https://github.com/Jacky-LinPeng/GLBubbleTextTipsView.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lin peng' => 'linpeng.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/Jacky-LinPeng/GLBubbleTextTipsView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GLBubbleTextTipsView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GLBubbleTextTipsView' => ['GLBubbleTextTipsView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'Masonry'
end
