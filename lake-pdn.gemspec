# Generated automatically with lake-gen
Gem::Specification.new do |s|
  s.name        = 'lake-pdn'
  s.version     = '0.0.1'
  s.licenses    = ['MIT']
  s.summary     = "Lake - a Make-style build system"
  s.description = "Lake - a Make-style build system with Ruby syntax"
  s.authors     = [

    'unn4m3d'

  ]
  s.email       = 'smelnikov871@gmail.com'
  s.files       = [

    'lib/lake/plugins/pdn.rb'

  ]
  s.homepage    = 'https://gtihub.com/unn4m3d/lake-pdn'

  #s.add_runtime_dependency "lake" ,">=0.1.5","~>0.1.0"
  s.add_runtime_dependency "ruby-progressbar"
  s.add_runtime_dependency "em-http-request"
end
