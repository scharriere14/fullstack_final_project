ActiveAdmin.register Customer do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :customer_first, :customer_last, :address_id, :email, :password
  #
  index do
    selectable_column
    id_column
    column :customer_first
    column :customer_last
    column :address_id
    column :email
    actions
  end
  # or
  #
  # permit_params do
  #   permitted = [:customer_first, :customer_last, :address_id, :email_address, :password]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
