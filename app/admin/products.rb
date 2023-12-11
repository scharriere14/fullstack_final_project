ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  filter :product_name
  filter :price
  filter :stock
  filter :scent
  filter :consistency
  filter :usage
  #filter :image
  #filter :image_cont, label: 'Image', as: :string


  permit_params :product_name, :price, :stock, :scent, :consistency, :description, :usage # :image

  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :price, :stock, :scent, :consistency, :usage]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
