require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  describe "instance methods" do
    it "can calculate average price of snacks in a particular machine" do
      owner = Owner.create!(name: "Sam's Snacks")
      dons  = owner.machines.create!(location: "Don's Mixed Drinks")

      snack_1 = dons.snacks.create!(name: "Kit Kat", price: 1.00)
      snack_2 = dons.snacks.create!(name: "Twix", price: 1.50)
      snack_3 = dons.snacks.create!(name: "Snickers", price: 2.00)

      expect(dons.average_price).to eq(1.5)
    end
  end
end
