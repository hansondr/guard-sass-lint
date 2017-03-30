module Guard
  module Sass
    module Lint
      class Railtie < Rails::Railtie
        rake_tasks do
          load 'tasks/sasslint.rake'
        end
      end
    end
  end
end
