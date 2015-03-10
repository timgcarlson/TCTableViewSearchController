#
# Be sure to run `pod lib lint TCTableViewSearchController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TCTableViewSearchController"
  s.version          = "0.1.0"
  s.summary          = "A subclass of UITableViewController that handles basic search bar functionality to make searching a table a painless process."
  s.description      = <<-DESC
                       Sometimes all you want is a table view that will handle most of the basic searching for you. That's where TCTableViewSearchController comes in. It handles most of the UISearchController requirements for you. All that you will need to do is implement one method that tells it which properties to search in the objects populatiung your table view. Currently only supports searching strings and numbers. Also has basic, optional, scope bar support.

                       **This includes a demo project to show you the ropes. See the README file for usage instructions.**
                       DESC
  s.homepage         = "https://github.com/timgcarlson/TCTableViewSearchController"
  # s.screenshots     = "http://www.timgcarlson.com/?p=452", "http://www.timgcarlson.com/?p=450"
  s.license          = 'MIT'
  s.author           = { "Tim G Carlson" => "timgcarlson@gmail.com" }
  s.source           = { :git => "https://github.com/timgcarlson/TCTableViewSearchController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/timgcarlson'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'TCTableViewSearchController' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/TCTableViewSearchController.h'
  s.frameworks = 'UIKit'
end
