$LOAD_PATH.unshift 'lib'

Gem::Specification.new do |s|
  s.name              = "ms-translate"
  s.version           = 0.1
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = ""
  s.homepage          = "https://github.com/elubow/ms-translate"
  s.email             = "eric@lubow.org"
  s.authors           = [ "Eric Lubow" ]

  s.files             = %w( README.md LICENSE )
  s.files            += Dir.glob("lib/**/*")

  s.extra_rdoc_files  = [ "LICENSE", "README.md" ]
  s.rdoc_options      = ["--charset=UTF-8"]

  s.add_dependency "nokogiri"

  s.description = <<description
description
end
