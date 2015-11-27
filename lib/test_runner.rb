require 'tempfile'

class TestRunner < Mumukit::FileTestRunner
  include Mumukit::WithIsolatedEnvironment

  def post_process_file(file, result, status)
    if result.include? '!!TEST FINISHED WITH COMPILATION ERROR!!'
      [result, :errored]
    else
      [result, status]
    end
  end

  def run_test_command(filename)
    "#{runcspec_command} #{filename}"
  end

end
