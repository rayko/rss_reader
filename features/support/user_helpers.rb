module UserHelpers
  def create_test_account
    return FactoryGirl.create :test_user
  end

  def confirm_test_account
    retrive_test_account.confirm!
  end

  def create_and_confirm_test_account
    create_test_account
    confirm_test_account
  end

  def retrive_test_account username='lolcat'
    User.find_by_username('lolcat')
  end

  def login_test_account_with_email
    user = retrive_test_account
    login_test_account(user.email)
  end

  def login_test_account_with_username
    user = retrive_test_account
    login_test_account(user.username)
  end

  def login_test_account(authentication_name)
    visit new_user_session_path
    fill_in('user_login', :with => authentication_name)
    fill_in('user_password', :with => '123456789')
    click_button 'Sign In'
  end
end
