Pod::Spec.new do |s|
    s.name         = "EasyImagy"
    s.version      = "0.5.2"
    s.summary      = "Easy manipulate pixel images"
    s.author       = { "koher" => "" }
    s.homepage     = "https://github.com/koher/EasyImagy"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.source       = { :git => "https://github.com/AJTY/EasyImagy.git", :tag => "#{s.version}" }
    s.platform     = :ios, '10.0'
   
    s.requires_arc = true
    s.source_files  = "Sources/EasyImagy/*"
   end
