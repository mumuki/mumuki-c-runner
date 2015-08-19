require 'tempfile'

class TestRunner  < Mumukit::FileTestRunner

  def gcc_command
    @config['gcc_command'] || 'gcc'
  end

  def run_test_file!(test_file)
    output_file = Tempfile.new('mumuki.cspec.test')
    compilation_output, compilation_status = [
      %x{#{compile_test_file_command(test_file.path, output_file.path)}},
      $?.success? ? :passed : :failed
    ]
    return [compilation_output, :failed] if compilation_status == :failed
    output_file.close
    [ %x{#{output_file.path}}, $?.success? ? :passed : :failed ]
  end

  def compile_test_file_command(test_file, output_file)
    "#{gcc_command} #{test_file} -o #{output_file} -lcspecs"
  end

end
