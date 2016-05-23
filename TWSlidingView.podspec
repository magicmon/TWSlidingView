#
# Be sure to run `pod lib lint TWSlidingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TWSlidingView'
  s.version          = '0.2.0'
  s.summary          = 'create a slide animation on the UIView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'create a slide animation on the UIView. like a android screen slide style'

  s.homepage         = 'https://github.com/magicmon/TWSlidingView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'magicmon' => 'sagun25si@gmail.com' }
  s.source           = { :git => 'https://github.com/magicmon/TWSlidingView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TWSlidingView/Classes/**/*'
end
