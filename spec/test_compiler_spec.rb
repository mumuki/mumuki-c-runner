require_relative './spec_helper'

describe 'compilation' do
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
    let(:compiler) { TestHook.new(nil) }
    let(:request) { OpenStruct.new(test: true_test, extra: 'char _true = 0;', content: true_submission) }
    it { expect(compiler.compile_file_content(request)).to eq(compiled_test_submission) }
  end

end
