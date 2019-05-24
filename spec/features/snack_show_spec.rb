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
    
    MachineSnack.create!(snack_id: @snack_1, machine_id: @machine_1)
    MachineSnack.create!(snack_id: @snack_1, machine_id: @machine_2)
    MachineSnack.create!(snack_id: @snack_1, machine_id: @machine_3)
  end

  it "I see the name of that snack" do
    visit snack_path(@snack_1)
    expect(current_path).to eq(snack_path(@snack_1))
    expect(page).to have_content(@snack_1.name)
  end
end
