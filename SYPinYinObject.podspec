Pod::Spec.new do |s|
  s.name         = "SYPinYinObject"
  s.version      = "1.0.0"
  s.summary      = "SYPinYinObject is used to make chinese word transform pinyin as easy as possible."
  s.homepage     = "https://github.com/potato512/SYPinYinObject"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "devZhang" => "zhangsy757@163.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/potato512/SYPinYinObject.git", :tag => "#{s.version}" }
  s.source_files  =  "SYPinYinObject/*.{h,m}"
  s.requires_arc = true
end