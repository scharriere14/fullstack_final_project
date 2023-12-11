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

  permit_params :product_name, :price, :stock, :scent, :consistency, :description, :usage, :image

# ...

index do
  column :product_name
  column :price do |product|
    number_to_currency(product.price / 100.0, precision: 2)
  end
  column :stock
  column :scent
  column :consistency
  column :usage
  column :image do |product|
    if product.image.attached?
      resized_image = product.image.variant(resize_to_limit: [100, 100]).processed
      puts "Original Image Size: #{product.image.blob.byte_size} bytes"
      puts "Resized Image Size: #{resized_image.blob.byte_size} bytes"
      image_tag(resized_image.service_url + "?v=#{product.updated_at.to_i}")
    else
      content_tag(:span, "No Image Attached")
    end
  end
  actions
end

# ...

  #
  # or
  #
  # permit_params do
  #   permitted = [:product_name, :price, :stock, :scent, :consistency, :usage]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # form do |f|
  #   f.semantic_errors
  #   f.inputs do
  #     f.input :image, as: :file,
  #     hint: f.object.image.present? ? image.tag(f.object.image.variant(resize_to_limit: [500, 500])) : ''
  #   end
  #   f.actions
  # end
end
