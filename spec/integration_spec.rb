require 'active_support/all'
require 'mumukit/bridge'

describe 'Server' do
  let(:bridge) { Mumukit::Bridge::Bridge.new('http://localhost:4568') }

  before(:all) do
    @pid = Process.spawn 'rackup -p 4568', err: '/dev/null'
    sleep 8
  end
  after(:all) { Process.kill 'TERM', @pid }

  it 'answers a valid hash when submission passes' do
    response = bridge.run_tests!(test: %q{
    it ("is true") { should_bool(_true) be truthy; } end
}, extra: 'char _true = 0;', content: %q{_true = 1;}, expectations: [])

    expect(response[:result]).to include('1 success')
    expect(response[:status]).to eq(:passed)
  end


  it 'answers a valid hash when submission fails' do
    response = bridge.run_tests!(test: %q{
    it ("is true") { should_bool(_true) be truthy; } end
}, extra: 'char _true = 0;', content: %q{_true = 0;}, expectations: [])

    expect(response[:status]).to eq(:failed)
    expect(response[:result]).to include('1 failure')
    expect(response[:result]).to include('0 success')
  end



end
