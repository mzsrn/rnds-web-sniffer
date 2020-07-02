RSpec.describe Collar do           
  
  let(:user) { create :user}

  it 'should be ok' do
    expect(user.id).to eq(1)
  end

end