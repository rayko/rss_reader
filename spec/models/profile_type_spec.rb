require 'spec_helper'

describe ProfileType do
  before(:all) do
    ProfileType.delete_all
    @profile_type = create(:profile_type)
    create(:profile_type, :name => 'Premium')
  end
  it 'shows a display name' do
    expect(@profile_type.display_name).to eq("#{@profile_type.name} - #{@profile_type.channel_limit} channels")
  end

  it 'gets default profile' do
    expect(ProfileType.default_profile).to eq(@profile_type)
  end
end
