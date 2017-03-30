require 'colorize'

module Guard
  module Sass
    module Lint
      class Runner
        def initialize(file, linter)
          @file = file
          @linter = linter
        end

        def run
          display_result @linter.lint(@file)
        end

        def display_result(result_data)
          result_data.each do |data|
            if data['warningCount'] > 0 || data['errorCount'] > 0
              puts "⌕ #{data['filePath']}"
              data['messages'].each { |msg| puts format_message(msg) }
            end
          end

          puts clean_message if result_data.empty?
        end

        private

        def format_message(data)
          location = [sprintf("%4d", data['line']), sprintf("%-4d", data['column'])].join(':')
          rule = sprintf("%-25s", "(#{data['ruleId']})")
          message = "  #{rule} #{location} - #{data['message']}"
          case data['severity']
          when 1
            message.green
          when 2
            message.yellow
          else
            message
          end
        end

        def clean_message
          ['✓'.green, @file].join(' ')
        end
      end
    end
  end
end
