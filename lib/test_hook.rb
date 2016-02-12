class TestHook < Mumukit::Templates::FileHook
  isolated true

  def tempfile_extension
    '.c'
  end

  def command_line(filename)
    "#{runcspec_command} #{filename}"
  end

  def post_process_file(file, result, status)
    if result.include? '!!TEST FINISHED WITH COMPILATION ERROR!!'
      [result, :errored]
    else
      super
    end
  end

  def compile_file_content(request)
    <<EOF
#include <cspecs/cspec.h>

context (mumuki_test) {

    describe ("Mumuki test") {

        #{request.extra}

        #{request.content}

        #{request.test}

    } end

}
EOF
  end
end