require 'active_support/all'
require 'mumukit/bridge'

describe 'Server' do
  let(:bridge) { Mumukit::Bridge::Runner.new('http://localhost:4568') }

  before(:all) do
    @pid = Process.spawn 'rackup -p 4568', err: '/dev/null'
    sleep 8
  end
  after(:all) { Process.kill 'TERM', @pid }

  it 'answers a valid hash when submission passes' do
    response = bridge.run_tests!(test: %q{
    it ("is true") { should_bool(_true) be truthy; } end
}, extra: 'char _true = 0;', content: %q{_true = 1;}, expectations: [])

    expect(response).to eq response_type: :structured,
                           test_results: [{title: 'Mumuki test, is true', status: :passed, result: nil}],
                           status: :passed,
                           feedback: '',
                           expectation_results: [],
                           result: ''
  end

  it 'answers a valid hash when submission fails' do
    response = bridge.run_tests!(test: %q{
    it ("is true") { should_bool(_true) be truthy; } end
}, extra: 'char _true = 0;', content: %q{_true = 0;}, expectations: [])

    expect(response).to eq response_type: :structured,
                           test_results: [{title: 'Mumuki test, is true',
                                           status: :failed,
                                           result: 'Expected <true> but was <false>'}],
                           status: :failed,
                           feedback: '',
                           result: '',
                           expectation_results: []
  end

  it 'answers a valid hash when submission errored' do
    response = bridge.run_tests!(test: %q{
    it "is true { should_bool(_true) be truthy; } end
}, extra: 'char _true = 0;', content: %q{_true = 0;}, expectations: [])

    expect(response.except(:result)).to eq(response_type: :unstructured,
                                           test_results: [],
                                           status: :errored,
                                           feedback: '',
                                           expectation_results: [])
    expect(response[:result]).to include "error: expected ';' before '}'"
  end
end
