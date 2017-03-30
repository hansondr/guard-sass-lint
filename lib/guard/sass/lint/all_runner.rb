require 'colorize'

module Guard
  module Sass
    module Lint
      class AllRunner
        def initialize(linter)
          @linter = linter
          @results = {}
        end

        def run
          $stdout.sync = true

          sass_files.each do |file|
            calculate_result @linter.lint(file)
            print '.'
          end

          display_final_result
        end

        def lint(filename)
          calculate_result
        end

        private

        def sass_files
          @sass_files ||= Dir.glob('*/**/*.scss').sort
        end

        def calculate_result(result_data)
          if !result_data.nil? && !result_data.empty?
            data = result_data.first
            file_path = data['filePath']
            warnings = data['warningCount'].to_i
            errors = data['errorCount'].to_i
            @results[file_path] = { warn: warnings, error: errors }
          end
        end

        def display_final_result
          puts "\n"
          puts ' Error Warn' if @results.present?
          @results.each do |file, counts|
            errors = sprintf('%4d', counts[:error]).red
            warns = sprintf('%4d', counts[:warn]).yellow
            puts "  #{errors} #{warns} - #{file}"
          end

          @results = {}
        end
      end
    end
  end
end
