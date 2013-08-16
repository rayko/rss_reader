ActiveAdmin.register User do
  index do
    column :id
    column :username
    column :email
    column :first_name
    column :last_name
    column :last_sign_in_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :profile_type
    end
    f.actions
  end

end
