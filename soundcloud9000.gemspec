$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name          = "soundcloud9000"
  s.version       = "0.1.3"
  s.authors       = ["Tobias Schmidt", "Matthias Georgi", "Sumanth Ratna"]
  s.email         = "sratna@sumanthratna.ml"
  s.homepage      = "http://www.github.com/sumanthratna/soundcloud9000"
  s.metadata      = {
    "source_code_uri" => "http://www.github.com/sumanthratna/soundcloud9000",
    "bug_tracker_uri" => "http://www.github.com/sumanthratna/soundcloud9000/issues"
  }
  s.requirements  << "PortAudio"
  s.requirements  << "mpg123"
  s.summary       = "SoundCloud without the stupid CSS files"
  s.description   = "The next generation SoundCloud client"
  s.license       = 'MIT'

  s.bindir        = 'bin'
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "json", "~> 1.8"
  s.add_dependency "audite", "~> 0.4"
  s.add_dependency "curses", "~> 1.0"

  s.add_development_dependency "bundler", "~> 2.1"
  s.add_development_dependency "rake", "~> 12.3"
  s.add_development_dependency "mocha", "~> 1.1"

  s.extra_rdoc_files = ["README.md"]
end
