require_relative '../lib/test_compiler'

describe TestCompiler do
  true_test = <<EOT
it ("is true") {
  should_bool(_true) be truthy;
} end
EOT

  true_submission = <<EOT
_true = 1;
EOT

  compiled_test_submission = <<EOT
#include <cspecs/cspec.h>

context (mumuki_test) {

    describe ("Mumuki test") {

        char _true = 0;

        _true = 1;


        it ("is true") {
  should_bool(_true) be truthy;
} end


    } end

}
EOT

  describe '#compile' do
    let(:compiler) { TestCompiler.new(nil) }
    it {
      expect(compiler.compile(true_test, 'char _true = 0;', true_submission)).to eq(compiled_test_submission)
    }
  end

end
