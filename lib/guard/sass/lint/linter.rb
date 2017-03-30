module Guard
  module Sass
    module Lint
      class Linter
        OUTPUT_FILE = 'tmp/sass_lint_results.json'.freeze

        def initialize(config_location = nil)
          @config_location = config_location
          @results = {}
        end

        def lint(file)
          clear_results
          system lint_command(file)
          result_data
        end

        private

        def root
          File.expand_path('../../../../..', __FILE__)
        end

        def sass_lint_dir
          @sass_lint_dir ||= File.join(root, 'node_modules', 'sass-lint')
        end

        def lint_command(filename)
          [linter, config, format, output, additional, filename, quiet].join(' ')
        end

        def linter
          File.join(sass_lint_dir, 'bin', 'sass-lint.js')
        end

        def config
          "-c #{config_file}"
        end

        def config_file
          @config_location || default_config
        end

        def default_config
          File.join(sass_lint_dir, 'docs', 'sass-lint.yml')
        end

        def format
          '-f json'
        end

        def additional
          '--no-exit --verbose'
        end

        def output
          "-o #{OUTPUT_FILE}"
        end

        def quiet
          ' >/dev/null 2>&1'
        end

        def result_data
          @result_data ||= result_json_file || []
        end

        def clear_results
          File.delete(OUTPUT_FILE) if File.exists?(OUTPUT_FILE)
          @result_data = nil
        end

        def result_json_file
          JSON.parse(File.new(OUTPUT_FILE).read) if File.exists?(OUTPUT_FILE)
        end
      end
    end
  end
end
