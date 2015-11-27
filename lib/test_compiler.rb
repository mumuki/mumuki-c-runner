class TestCompiler < Mumukit::FileTestCompiler

  def create_tempfile
    Tempfile.new(['mumuki.compile', '.c'])
  end

  def compile(request)
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
