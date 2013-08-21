module NavHelpers
  def sign_in_button
  end

  def login_link
  end

  def sign_up_link
    click_link "Sign Up"
  end

  def home_link
  end

  def goto_home_section
    visit root_path
  end

  def goto_channel_index
    visit user_channels_path
  end

  def wait_ajax_calls
    until page.evaluate_script('$.active') == 0
      'lol wating ajax'
    end
  end

end
