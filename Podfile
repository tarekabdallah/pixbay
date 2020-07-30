# Uncomment the next line to define a global platform for your project
platform :ios, '13.5'

use_frameworks!
inhibit_all_warnings!

def firebase_pods
  pod 'Firebase', '~> 6.24.0'
  pod 'Firebase/Auth', '~> 6.24.0'
end

def shared_pods
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Kingfisher', '~> 5.13'
  pod 'SideMenuSwift', '~> 2'
  pod 'Keyboard+LayoutGuide', '~> 1.6.0'
  pod 'NVActivityIndicatorView', '~> 4.8.0'
  pod 'netfox'
  pod 'SwiftLint', '~> 0.39.2'

  firebase_pods
end

target 'PixbayApp' do
  shared_pods
end

target 'PixbayAppTests' do

end