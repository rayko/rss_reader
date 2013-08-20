ActiveAdmin.register ProfileType do
  index do
    column :name
    column :channel_limit
  end

  form do |f|
    f.inputs 'Profile Type' do
      f.input :name
      f.input :channel_limit
    end
  end


end
