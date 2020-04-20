require_relative 'spec_helper'

describe CExpectationsHook do
  def req(expectations, content)
    struct expectations: expectations, content: content
  end

  def compile_and_run(request)
    runner.run!(runner.compile(request))
  end

  let(:runner) { CExpectationsHook.new }
  let(:result) { compile_and_run(req(expectations, code)) }

  describe 'DeclaresFunction' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar = 4;" }
    let(:expectations) { [
        {binding: '*', inspection: 'DeclaresFunction:foo'},
        {binding: '*', inspection: 'DeclaresFunction:bar'},
        {binding: '*', inspection: 'DeclaresFunction:baz'}] }

    it { expect(result).to eq [
                                  {expectation: expectations[0], result: true},
                                  {expectation: expectations[1], result: false},
                                  {expectation: expectations[2], result: false}] }
  end

  describe 'DeclaresVariable' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar = 4;" }
    let(:expectations) { [
        {binding: '*', inspection: 'DeclaresVariable:foo'},
        {binding: '*', inspection: 'DeclaresVariable:bar'},
        {binding: '*', inspection: 'DeclaresVariable:baz'}] }

    it { expect(result).to eq [
                                  {expectation: expectations[0], result: false},
                                  {expectation: expectations[1], result: true},
                                  {expectation: expectations[2], result: false}] }
  end

  describe 'Declares' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar = 4;" }
    let(:expectations) { [
        {binding: '*', inspection: 'Declares:foo'},
        {binding: '*', inspection: 'Declares:bar'},
        {binding: '*', inspection: 'Declares:baz'}] }

    it { expect(result).to eq [
                                  {expectation: expectations[0], result: true},
                                  {expectation: expectations[1], result: true},
                                  {expectation: expectations[2], result: false}] }
  end

end
