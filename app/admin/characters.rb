ActiveAdmin.register Character do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :reward, :devilfruit, :fruit_type, :age, :birthplace, :height, :favourite, :birthday, :url
  #
  # or
  #



  permit_params do
    array = Character.attribute_names - %w(id created_at updated_at fruit_type orther)
    permitted = array.map &:to_sym
  end

  index do
    selectable_column
    id_column
    column :name
    column :romaji_name
    column :group
    column :reward
    column :ranking
    column :devilfruit
    column :height
    column :age
    actions
  end

  show do
    attributes_table do
      row :name
      row :spec_name
      row :romaji_name
      row :group
      row :reward
      row :ranking
      row :devilfruit
      row :age
      row :height
      row :birthplace
      row :birthday
      row :favourite
      row :haki
      row :weapon
      row :url
      row :memo
      row :created_at
      row :updated_at
    end
  end

  form title: 'Characters' do |f|
    f.inputs 'Character' do
      input :name
      input :spec_name
      input :romaji_name
      input :group
      input :reward
      input :ranking
      input :devilfruit
      input :age
      input :height
      input :birthplace
      input :birthday
      input :favourite
      input :haki
      input :weapon
      input :url
      input :memo
    end
    actions
  end


end
