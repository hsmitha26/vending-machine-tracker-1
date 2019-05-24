# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.

require 'rails_helper'

RSpec.describe "When I visit a snack show page" do
  before :each do
    @owner = Owner.create!(name: "Sam's Snacks")
    @owner_2 = Owner.create!(name: "Owner Two")

    @machine_1  = @owner.machines.create!(location: "Machine One")
    @machine_2  = @owner_2.machines.create!(location: "Machine Two")
    @machine_3  = @owner.machines.create!(location: "Machine Three")

    @snack_1 = Snack.create!(name: "Kit Kat", price: 1.00)
    MachineSnack.create!(snack: @snack_1, machine: @machine_1)
    MachineSnack.create!(snack: @snack_1, machine: @machine_2)
    MachineSnack.create!(snack: @snack_1, machine: @machine_3)

    @snack_2 = Snack.create!(name: "Twix", price: 1.50)
    MachineSnack.create!(snack: @snack_2, machine: @machine_1)
    MachineSnack.create!(snack: @snack_2, machine: @machine_2)

    @snack_3 = Snack.create!(name: "Snickers", price: 2.50)
    MachineSnack.create!(snack: @snack_3, machine: @machine_2)
    MachineSnack.create!(snack: @snack_3, machine: @machine_3)
  end

  it "I see the name and price of that snack" do
    visit snack_path(@snack_1)
    expect(current_path).to eq(snack_path(@snack_1))
    expect(page).to have_content(@snack_1.name)
    expect(page).to have_content(@snack_1.price)
  end

  it "I see a list of locations with vending machines that carry that snack and average price for snacks in each machine" do
    visit snack_path(@snack_1)

    within ("#machines-#{@machine_1.id}") do
      expect(page).to have_content("Machine One")
      expect(page).to have_content("$#{@machine_1.average_price.to_f.round(2)}")
    end
    within ("#machines-#{@machine_2.id}") do
      expect(page).to have_content("Machine Two")
      expect(page).to have_content("$#{@machine_2.average_price.to_f.round(2)}")
    end
    within ("#machines-#{@machine_3.id}") do
      expect(page).to have_content("Machine Three")
      expect(page).to have_content("$#{@machine_3.average_price.to_f.round(2)}")
    end
  end
end
