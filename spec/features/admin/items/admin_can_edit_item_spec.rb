require 'rails_helper'

describe 'As an admin' do
  describe 'on the admin/acc/edit page' do
    it 'admin can edit item' do
      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      item = Item.create(title: "Handlebars", price: "35.00", image: 'bike_gear.jpg', description: 'Use to steer your bike.', status: 1)
      old_title = item.title
      old_price = item.price
      old_description = item.description

      visit admin_bike_shop_path

      within "#item-#{item.id}" do
        click_on('Edit')
      end

      expect(current_path).to eq(edit_admin_item_path(item))

      title = 'biking shorts'
      price = 10
      description = 'lycra'
      image = 'bike_gear.jpg'
      status = 'active'

      fill_in :item_title, with: title
      fill_in :item_price, with: price
      fill_in :item_description, with: description
      fill_in :item_image, with: image
      find("#item_status").find(:option, status).select_option

      click_on('Update Item')

      expect(current_path).to eq item_path(item)

      expect(page).to have_content("#{title} has been updated.")
      expect(page).to have_content(title)
      expect(page).to have_content(price)
      expect(page).to have_content(description)
      expect(page).to_not have_content(old_title)
      expect(page).to_not have_content(old_price)
      expect(page).to_not have_content(old_description)
    end
  end
end
