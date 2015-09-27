require 'rails_helper'

feature 'Categories restfulness' do
  it 'displays all categories' do
    visit '/categories'
    expect(current_path).to eq(categories_path)
    Category.all.each do |cat|
      expect(page).to have_content(cat.title)
    end
  end

  it "shows each category\'s items" do
    visit '/categories'
    Category.all.each do |cat|
      cat.items.each do |item|
        expect(page).to have_content(item.title)
      end
    end
  end

  it "can view an individual category which includes corresponding items" do
    visit '/categories'
    cat = Category.first
    expect(page).to have_link(cat.title, cat)
    click_link(cat.title, cat)
    expect(current_path).to eq(category_path(cat))
    cat.items.each do |item|
      expect(page).to have_link(item.title, item)
    end
  end

  it "can delete categories" do
    visit '/categories'
    Category.all.each do |cat|
      expect(page).to have_link("Delete", category_path(cat))
    end
    cat_count = Category.count
    first(:link, "Delete").click
    expect(Category.count).to eq(cat_count - 1)
  end

  it "can create a new category" do
    visit '/categories'
    expect(page).to have_link("Create New Category")
    click_link("Create New Category")
    expect(current_path).to eq("/categories/new")
  end

  it "can visit items from categories index" do
    visit '/categories'
    Category.first.items.each do |item|
      expect(page).to have_link(item.title, item)
    end
    test_item = Category.first.items.first
    first(:link, test_item.title).click
    expect(current_path).to eq(item_path(test_item))

  end

end