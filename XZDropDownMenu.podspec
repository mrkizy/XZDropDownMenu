Pod::Spec.new do |s|
s.name         = "XZDropDownMenu"
s.version      = "0.1.2"
s.summary      = "ios版简单易用的下拉筛选多菜单控件"
s.description  = "一个ios版简单易用的下拉筛选多菜单控件，支持自定义排列方式，支持UITableView和UICollectionView的展示方式，可下载直接使用在项目中。"

s.homepage     = "https://github.com/mrkizy/XZDropDownMenu"
s.license      = "MIT"
s.author             = { "kizy" => "358033194@qq.com" }
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/mrkizy/XZDropDownMenu.git", :tag => "#{s.version}" }
s.source_files  = "XZDropDownMenu/**/*.{h,m}"
s.dependency "Masonry"
end
