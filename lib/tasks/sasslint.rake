require 'guard-sass-lint'

namespace :sasslint do
  desc 'Run sass-lint against the specified JavaScript file and report warnings (default is "application")'
  task :run, [:filename, :config_location] => :environment do |_, args|
    file = args.fetch(:filename, nil)
    config_location = args.fetch(:config_location)
    linter = Guard::Sass::Lint::Linter.new(config_location)

    if file
      Guard::Sass::Lint::Runner.new(file, linter).run
    else
      Guard::Sass::Lint::AllRunner.new(linter).run
    end
  end
end
