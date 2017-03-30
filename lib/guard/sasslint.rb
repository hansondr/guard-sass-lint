require 'guard/compat/plugin'
require 'rake'
require 'mkmf'

module Guard
  class Sasslint < Plugin
    RAKETASK = 'sasslint:run'.freeze

    def initialize(options = {})
      enforce_js_dependencies!

      @config = options.fetch(:config, nil)
      @run_at_start = options.fetch(:run_at_start, false)
      load 'Rakefile'

      super options
    end

    def start
      UI.info 'sasslint starting...'
      run_all if @run_at_start
    end

    def run_all
      UI.info 'sasslint ⇒ all sass'
      lint
    end

    def run_on_changes(paths)
      paths.each { |path| lint path }
    end

    private

    def lint(file = nil)
      ::Rake::Task[RAKETASK].reenable
      ::Rake::Task[RAKETASK].invoke(file, @config)
    end

    def enforce_js_dependencies!
      if !find_dependency 'yarnpkg'
        UI.error 'Unable to locate the yarnpkg library'
        UI.error 'To install yarn visit: https://yarnpkg.com/en/docs/install'
        exit 1
      end

      if !find_dependency 'node'
        UI.error 'Unable to locate the node binary'
        UI.error 'Depending on OS and install method used you may need to symlink node to nodejs'
        exit 1
      end
    end

    # this hacky workaround prevents mkmf from polluting the project with
    # mkmf.log files
    def find_dependency(executable)
      old_mkmf_log = MakeMakefile::Logging.instance_variable_get(:@logfile)
      set_mkmf_log(nil)
      path_to_cmd = find_executable0(executable)
      set_mkmf_log(old_mkmf_log)

      path_to_cmd
    end

    def set_mkmf_log(logfile = File::NULL)
      MakeMakefile::Logging.instance_variable_set(:@logfile, logfile)
    end
  end
end
