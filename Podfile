# Uncomment the next line to define a global platform for your project

source 'https://github.com/CocoaPods/Specs'

inhibit_all_warnings!

platform :ios, '10.0'

use_frameworks!

target 'Emperapool' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'DCKit', '~> 1.0.12'
  
  pod 'CodableAlamofire', '~> 1.1.0'
  
  pod 'UIColor_Hex_Swift', '~> 4.0.2'
  
  pod 'Kingfisher', '~> 4.10.0'
  
  pod 'ObjectMapper', '~> 3.3.0'
  
  pod 'Toast-Swift', '~> 4.0.0'
  
  pod 'IQKeyboardManagerSwift', '~> 6.1.1'
  
  pod 'AlamofireNetworkActivityLogger', '~> 2.3.0'
  
  # Pods for Emperapool

  target 'EmperapoolTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'EmperapoolUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
  end
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end


