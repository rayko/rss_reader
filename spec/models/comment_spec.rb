require 'spec_helper'

describe Comment do
  before(:all) do
    @profile_type = create(:profile_type)
    @user = create(:generic_user)
    @channel = create(:channel, :user_id => @user.id)
    @article = create(:article, :channel_id => @channel.id)
    @valid_comment = build(:comment, :user_id => @user.id, :article_hash_tag => @article.hash_tag)
    @invalid_comment = build(:comment)
  end
  it 'rejects invalid record' do
    expect(@invalid_comment.save).to eq(false)
  end

  it 'stores valid record' do
    expect(@valid_comment.save).to eq(true)
  end

  it 'retrives username' do
    expect(@valid_comment.user_username).to eq(@user.username)
  end
end
