require "rails_helper"

describe "As an authenticated admin" do
  describe "when I visit the admin bike shop" do
    it 'should have all items in bike shop' do
      admin = create(:user, role: 1)
      items = create_list(:item, 12)
      item_13 = create(:item, status: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      within("#item-#{items.first.id}") do
        expect(page).to have_content(items.first.name)
        expect(page).to have_content(items.first.description)
        expect(page).to have_content(items.first.status)
        expect(page).to have_content("Edit")
      end
      within("#item-#{items.last.id}") do 
        expect(page).to have_content(items.last.name)
        expect(page).to have_content(items.last.description)
        expect(page).to have_content(items.last.status)
        expect(page).to have_content("Edit")
      end
    end
  end
end
