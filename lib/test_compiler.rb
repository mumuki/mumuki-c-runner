require 'mumukit'

class TestCompiler
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
