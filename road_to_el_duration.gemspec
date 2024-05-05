require_relative "lib/road_to_el_duration/version"

Gem::Specification.new do |spec|
  spec.name        = "road_to_el_duration"
  spec.version     = RoadToElDuration::VERSION
  spec.authors     = ["Collin Jilbert"]
  spec.email       = ["cjilbert504@gmail.com"]
  spec.homepage    = "https://github.com/cjilbert504/road_to_el_duration"
  spec.summary     = "Easily update the duration of a parent object when child objects are added or removed."
  spec.description = "Easily update the duration of a parent object when child objects are added or removed."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cjilbert504/road_to_el_duration"
  spec.metadata["changelog_uri"] = "https://github.com/cjilbert504/road_to_el_duration/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3.2"
end
