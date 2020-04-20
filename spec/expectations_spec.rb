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

  describe 'HasTooShortIdentifiers' do
    let(:code) { "int f(int x, int y) { return x + y; }" }
    let(:expectations) { [] }

    it { expect(result).to eq [{expectation: {binding: 'f', inspection: 'HasTooShortIdentifiers'}, result: false}] }
  end

  describe 'DeclaresFunction' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar = 4;" }
    let(:expectations) { [
        {binding: '*', inspection: 'DeclaresFunction:foo'},
        {binding: '*', inspection: 'DeclaresFunction:bar'},
        {binding: '*', inspection: 'DeclaresFunction:zaz'}] }

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
        {binding: '*', inspection: 'DeclaresVariable:zaz'}] }

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
        {binding: '*', inspection: 'Declares:zaz'}] }

    it { expect(result).to eq [
                                  {expectation: expectations[0], result: true},
                                  {expectation: expectations[1], result: true},
                                  {expectation: expectations[2], result: false}] }
  end

  describe 'Uses:' do
    let(:code) { "int foo(int x, int y) { return bar(x + y); }" }
    let(:expectations) { [{binding: '*', inspection: 'Uses:foo'},
                          {binding: '*', inspection: 'Uses:bar'}] }

    it { expect(result).to eq [{expectation: expectations[0], result: false},
                               {expectation: expectations[1], result: true}] }
  end

  describe 'UsesIf' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar(int x, int y) { if (x) return y; }" }
    let(:expectations) { [{binding: 'foo', inspection: 'UsesIf'},
                          {binding: 'bar', inspection: 'UsesIf'}] }

    it { expect(result).to eq [{expectation: expectations[0], result: false},
                               {expectation: expectations[1], result: true}] }
  end

  describe 'UsesWhile' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar(int x, int y) { while (x) y; }" }
    let(:expectations) { [{binding: 'foo', inspection: 'UsesWhile'},
                          {binding: 'bar', inspection: 'UsesWhile'}] }

    it { expect(result).to eq [{expectation: expectations[0], result: false},
                               {expectation: expectations[1], result: true}] }
  end

  describe 'UsesFor' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar(int x, int y) { for (x;y;x++); }" }
    let(:expectations) { [{binding: 'foo', inspection: 'UsesForLoop'},
                          {binding: 'bar', inspection: 'UsesForLoop'}] }

    it { expect(result).to eq [{expectation: expectations[0], result: false},
                               {expectation: expectations[1], result: true}] }
  end

  describe 'UsesSwitch' do
    let(:code) { "int foo(int x, int y) { return x + y; }\nint bar(int x, int y) { switch (x) {}; }" }
    let(:expectations) { [{binding: 'foo', inspection: 'UsesSwitch'},
                          {binding: 'bar', inspection: 'UsesSwitch'}] }

    it { expect(result).to eq [{expectation: expectations[0], result: false},
                               {expectation: expectations[1], result: true}] }
  end

end
