require 'mumukit'

class TestCompiler

  def create_tempfile
    Tempfile.new(['mumuki.compile', '.c'])
  end

  def compile(test_src, extra_src, content_src)
    <<EOF
#include <cspecs/cspec.h>

context (mumuki_test) {

    describe ("Mumuki test") {

        #{extra_src}

        #{content_src}

        #{test_src}

    } end

}
EOF
  end
end
