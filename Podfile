# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'SwiftDokkiri' do
    inherit! :search_paths
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SwiftDokkiri
   pod 'Firebase/Analytics'
   pod 'Firebase/AdMob'
   # FirestoreはBoringSSL-GRPCのエラーが発生するため、UserDefaultsのみで実装
   # pod 'Firebase/Firestore'	

   target 'JudgementViewModelTests' do
       inherit! :search_paths
       # Pods for testing
   end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "12.0"
      
      # BoringSSL-GRPCのエラーを回避
      if target.name == "BoringSSL-GRPC" || target.name.include?("BoringSSL")
        other_cflags = config.build_settings["OTHER_CFLAGS"] || ""
        if other_cflags.is_a?(Array)
          config.build_settings["OTHER_CFLAGS"] = other_cflags.reject { |flag| flag == "-GCC_WARN_INHIBIT_ALL_WARNINGS" }
        elsif other_cflags.is_a?(String)
          config.build_settings["OTHER_CFLAGS"] = other_cflags.gsub(/-GCC_WARN_INHIBIT_ALL_WARNINGS\s*/, "")
        end
      end
    end
  end
end
