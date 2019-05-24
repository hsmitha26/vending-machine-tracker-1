require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page: ', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it "I see the name of all of the snacks associated with that vending machine along with their price" do
    owner = Owner.create!(name: "Sam's Snacks")
    dons  = owner.machines.create!(location: "Don's Mixed Drinks")

    snack_1 = dons.snacks.create!(name: "Kit Kat", price: 1.00)
    snack_2 = dons.snacks.create!(name: "Twix", price: 1.50)
    snack_3 = dons.snacks.create!(name: "Snickers", price: 2.00)

    visit machine_path(dons)
    expect(current_path).to eq(machine_path(dons))

    within ("#machine-snack-#{snack_1.id}") do
      expect(page).to have_content(snack_1.name)
      expect(page).to have_content("$#{snack_1.price}")
    end
    within ("#machine-snack-#{snack_2.id}") do
      expect(page).to have_content(snack_2.name)
      expect(page).to have_content("$#{snack_2.price}")
    end
    within ("#machine-snack-#{snack_3.id}") do
      expect(page).to have_content(snack_3.name)
      expect(page).to have_content("$#{snack_3.price}")
    end
  end
end
