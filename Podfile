# platform :ios, '9.0'

target 'HabitifyReport' do
  use_frameworks!
  inhibit_all_warnings!
  
  pod 'Charts'
  pod 'CombineCocoa'
  pod 'Factory'
  pod 'SwiftDate'
  pod 'SwiftLint'
  pod 'TinyConstraints'

  pod 'Peek', :configurations => ['Debug']

  target 'HabitifyReportTests' do
    inherit! :search_paths
    use_frameworks!
    pod 'MockingbirdFramework'
  end
end

