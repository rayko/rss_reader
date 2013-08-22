# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
  # Define a method which signs in as a valid user.
  def sign_in_as_a_valid_user
    # ASk factory girl to generate a valid user for us.
    @user ||= create :generic_user
    @user.confirm!
    # We action the login request using the parameters before we begin.
    # The login requests will match these to the user we just created in the factory, and authenticate us.
    post_via_redirect new_user_session_path, 'user[login]' => @user.email, 'user[password]' => '123456789'
  end
end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
  # Include the help for the request specs.
  config.include ValidUserRequestHelper, :type => :request
end
