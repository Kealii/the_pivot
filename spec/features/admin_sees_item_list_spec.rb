require 'rails_helper'

  describe 'admin item list' do

    before :each do
      login_admin!
    end

    it 'can view item list' do
      visit '/items'
      expect(page).to have_link("Delete")
      expect(page).to have_link("Create New Item")
      expect(page).to have_link("Edit")
    end

    it 'can view an individual item' do
      visit '/items'
      item = Item.find_by(title: 'pencil')
      click_on "pencil"
      expect(current_path).to eq(item_path(item))
      expect(page).to have_link("Delete")
      expect(page).to have_link("Edit")
    end

    it 'can edit an item' do
      visit '/items'
      item = Item.find_by(title: 'internet')

      within('.internet') do
        click_on "Edit"
      end

      expect(current_path).to eq(edit_admin_item_path(item))
      fill_in "item_title", with: "test item"
      fill_in "item_description", with: "test description"
      fill_in "item_price", with: "9999"
      click_on "Update Item"

      expect(current_path).to eq('/items')
      within('.table') do
        expect(page).to have_content('test item')
        within('.test') do
          expect(page).to have_content('$99.99')
        end
      end

    end
  end
