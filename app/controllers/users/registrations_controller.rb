class Users::RegistrationsController < Devise::RegistrationsController
  def update
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank? && !current_user.provider.blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    prev_unconfirmed_email = @user.unconfirmed_email if @user.respond_to?(:unconfirmed_email)

    if resource.update_with_password(account_update_params)

    end


    if current_user.provider.blank?
      updated = @user.update_with_password(params[:user])
    else
      updated = @user.update_attributes(params[:user])
      if update_needs_confirmation?(@user, prev_unconfirmed_email)
        @user.send_confirmation_instructions
      end
    end
    if updated
      if is_navigational_format?
        flash_key = update_needs_confirmation?(@user, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
end
