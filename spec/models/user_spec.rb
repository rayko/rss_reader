require 'spec_helper'

describe User do

  context 'with no content' do
    before do
      ProfileType.delete_all
      @profile_type = create(:profile_type)
      @valid_user = build(:valid_user)
      @invalid_user = build(:invalid_user)

      @invalid_field = ''
      51.times do
        @invalid_field << 'L'
      end

    end
    it 'stores a valid user' do
      expect(@valid_user.save).to eq(true)
    end

    it 'rejects an invalid user' do
      expect(@invalid_user.save).to eq(false)
    end

    it 'associates a profile_type' do
      @valid_user.save!

      expect(@valid_user.profile_type).to eq(@profile_type)
    end

    it 'validates lenght of first name' do
      @valid_user.first_name = @invalid_field
      expect(@valid_user.save).to eq(false)

      @valid_user.first_name = 'lolcat'
      expect(@valid_user.save).to eq(true)
    end

    it 'validates lenght of last name' do
      @valid_user.last_name = @invalid_field
      expect(@valid_user.save).to eq(false)

      @valid_user.last_name = 'lolcat'
      expect(@valid_user.save).to eq(true)
    end

    it 'validates lenght of username' do
      @valid_user.username = @invalid_field
      expect(@valid_user.save).to eq(false)

      @valid_user.username = 'lolcat'
      expect(@valid_user.save).to eq(true)
    end

    it 'gets a valid user from DB with login' do
      @valid_user.save

      fake_warden_conditions = { :login => @valid_user.username }
      expect(User.find_first_by_auth_conditions(fake_warden_conditions)).to eq(@valid_user)

      fake_warden_conditions = { :email => @valid_user.email }
      expect(User.find_first_by_auth_conditions(fake_warden_conditions)).to eq(@valid_user)

      fake_warden_conditions = { :login => 'nada' }
      expect(User.find_first_by_auth_conditions(fake_warden_conditions)).to eq(nil)
    end

    it 'authenticates with google'do
      pending 'Read devise docs to do the proper mocks'
    end

    it 'authenticates with twitter' do
      pending "Read devise docs to do the proper mocks"
    end

    it 'creates with session' do
      pending "don't know how to do this one"
    end
  end

  context 'with some site content' do
    before(:all) do
      @profile_type = create(:profile_type)
      @user = create(:valid_user)
      @channel_1 = create(:channel, :user_id => @user.id)
      @channel_2 = create(:channel, :user_id => @user.id)

      # Delete articles generated by feed manager from test feed
      Article.delete_all

      @channel_1.articles << create(:article, :read => true)
      @channel_1.articles << create(:article)
      @channel_1.articles << create(:article, :starred => true)
      @channel_2.articles << create(:article)
    end

    it 'gets full article list' do
      expect(@user.all_articles.size).to eq(4)
    end

    it 'gets starred articles' do
      expect(@user.starred_articles.size).to eq(1)
    end

    it 'gets articles count' do
      expect(@user.articles_count).to eq(4)
    end

    it 'gets starred articles count' do
      expect(@user.starred_articles_count).to eq(1)
    end

    it 'gets channel limit' do
      expect(@user.channel_limit).to eq(@profile_type.channel_limit)
    end
  end
end
