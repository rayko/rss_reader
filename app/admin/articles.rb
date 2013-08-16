ActiveAdmin.register Article do
  index do
    column :title
    column :link
    column :pub_date
    default_actions
  end

  form do |f|
    f.inputs "Article Details" do
      f.input :title
      f.input :link
      f.input :description
      f.input :pub_date
      f.input :starred
      f.input :read
    end
    f.actions
  end

end
