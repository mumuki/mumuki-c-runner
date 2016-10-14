require_relative 'spec_helper'

describe 'running' do
  let(:runner) { CTestHook.new(runcspec_command: 'runcspec') }

  describe '#run' do
    context 'on failed submission' do
      let(:file) { File.new 'spec/data/failed/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[0]).to eq [['Mumuki test, is true', :failed, 'Expected <true> but was <false>']] }
    end

    describe 'on errored submission' do
      let(:file) { File.new 'spec/data/errored/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[1]).to eq :errored }
      it { expect(result[0]).to include "error: expected '{' at end of input" }
    end

    describe 'on passed submission' do
      let(:file) { File.new 'spec/data/passed/compilation.c' }
      let(:result) { runner.run!(file) }

      it { expect(result[0]).to eq [['Mumuki test, is true', :passed, nil]] }
    end
  end
end
