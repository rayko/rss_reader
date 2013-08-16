ActiveAdmin.register AdminUser do
  index do
    column :username
    column :email
    column :last_sign_in_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
