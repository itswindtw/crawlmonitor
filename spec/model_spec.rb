require 'spec_helper'

describe Region do
  before do
    @u = Url.create(url: 'google.com/test')
    @r = @u.add_region(index: '123', hash_val: '456')
  end

  it 'publish change event after get updated' do
    expect(Event.count).to eq(0)
    @r.update(hash_val: '789')
    expect(Event.count).to eq(1)

    e = Event.first
    expect(e.url).to eq(@u.url)
    expect(e.index).to eq(@r.index)
    expect(e.hash_val).to eq(@r.hash_val)
  end
end
