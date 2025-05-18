
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FoodDelivery' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyHome
pod 'RxSwift', '6.5.0'
  # Reactive Extensions
  pod 'RxSwiftExt', '6.2.1'
  pod 'CRRefresh'
  pod 'CombineCocoa'
  pod 'SnapKit'
  pod 'NVActivityIndicatorView'
  pod 'NVActivityIndicatorView/Extended'
  pod 'PhoneNumberKit'
  pod 'AEOTPTextField'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'ReachabilitySwift'
  pod 'FSPagerView'
  pod 'Kingfisher'
  pod 'FittedSheets'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings['OTHER_SWIFT_FLAGS'] = '-no-verify-emitted-module-interface'
    end
  end
end
