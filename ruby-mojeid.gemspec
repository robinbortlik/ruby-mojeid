# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby-mojeid}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Bortlik"]
  s.date = %q{2011-02-01}
  s.description = %q{This gem extend ruby-openid gem}
  s.email = %q{robinbortlik@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "examples/README",
    "examples/rails_openid/Gemfile",
    "examples/rails_openid/Gemfile.lock",
    "examples/rails_openid/README",
    "examples/rails_openid/Rakefile",
    "examples/rails_openid/app/controllers/application_controller.rb",
    "examples/rails_openid/app/controllers/consumer_controller.rb",
    "examples/rails_openid/app/views/consumer/index.rhtml",
    "examples/rails_openid/config/boot.rb",
    "examples/rails_openid/config/database.sample.yml",
    "examples/rails_openid/config/environment.rb",
    "examples/rails_openid/config/environments/development.rb",
    "examples/rails_openid/config/environments/production.rb",
    "examples/rails_openid/config/environments/test.rb",
    "examples/rails_openid/config/preinitializer.rb",
    "examples/rails_openid/config/routes.rb",
    "examples/rails_openid/public/.htaccess",
    "examples/rails_openid/public/404.html",
    "examples/rails_openid/public/500.html",
    "examples/rails_openid/public/dispatch.cgi",
    "examples/rails_openid/public/dispatch.fcgi",
    "examples/rails_openid/public/dispatch.rb",
    "examples/rails_openid/public/favicon.ico",
    "examples/rails_openid/public/images/openid_login_bg.gif",
    "examples/rails_openid/public/javascripts/controls.js",
    "examples/rails_openid/public/javascripts/dragdrop.js",
    "examples/rails_openid/public/javascripts/effects.js",
    "examples/rails_openid/public/javascripts/prototype.js",
    "examples/rails_openid/public/robots.txt",
    "examples/rails_openid/script/about",
    "examples/rails_openid/script/breakpointer",
    "examples/rails_openid/script/console",
    "examples/rails_openid/script/destroy",
    "examples/rails_openid/script/generate",
    "examples/rails_openid/script/performance/benchmarker",
    "examples/rails_openid/script/performance/profiler",
    "examples/rails_openid/script/plugin",
    "examples/rails_openid/script/process/reaper",
    "examples/rails_openid/script/process/spawner",
    "examples/rails_openid/script/process/spinner",
    "examples/rails_openid/script/runner",
    "examples/rails_openid/script/server",
    "examples/rails_openid/test/functional/login_controller_test.rb",
    "examples/rails_openid/test/functional/server_controller_test.rb",
    "examples/rails_openid/test/test_helper.rb",
    "lib/available_attributes.rb",
    "lib/ruby-mojeid.rb",
    "lib/xrds_helpers.rb",
    "ruby-mojeid.gemspec",
    "test/helper.rb",
    "test/test_ruby-mojeid.rb"
  ]
  s.homepage = %q{http://github.com/robinbortlik/ruby-mojeid}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{This gem help use ruby-openid more simple}
  s.test_files = [
    "examples/rails_openid/app/controllers/application_controller.rb",
    "examples/rails_openid/app/controllers/consumer_controller.rb",
    "examples/rails_openid/config/boot.rb",
    "examples/rails_openid/config/environment.rb",
    "examples/rails_openid/config/environments/development.rb",
    "examples/rails_openid/config/environments/production.rb",
    "examples/rails_openid/config/environments/test.rb",
    "examples/rails_openid/config/preinitializer.rb",
    "examples/rails_openid/config/routes.rb",
    "examples/rails_openid/public/dispatch.rb",
    "examples/rails_openid/test/functional/login_controller_test.rb",
    "examples/rails_openid/test/functional/server_controller_test.rb",
    "examples/rails_openid/test/test_helper.rb",
    "test/helper.rb",
    "test/test_ruby-mojeid.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-openid>, ["= 2.1.8"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-openid>, ["= 2.1.8"])
    else
      s.add_dependency(%q<ruby-openid>, ["= 2.1.8"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<ruby-openid>, ["= 2.1.8"])
    end
  else
    s.add_dependency(%q<ruby-openid>, ["= 2.1.8"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<ruby-openid>, ["= 2.1.8"])
  end
end

