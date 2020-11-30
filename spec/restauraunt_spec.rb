require "spec_helper"
require "restaurant"
require "restaurant_owner"

RSpec.describe Restaurant do
  describe "#come_find_us" do
    context "when the address is nil" do
      it "returns a no set address message" do
        restaurant = FactoryBot.build_stubbed(:restaurant)

        result = restaurant.come_find_us

        expect(result).to eq("View our schedule online")
      end
    end

    context "when the address is not nil" do
      it "returns the atenated address" do
        restaurant = FactoryBot.build_stubbed(:restaurant, :with_address)

        result = restaurant.come_find_us

        expect(result)
          .to eq( "Come find us at 123 Main Street, Boston, MA 02122")
      end
    end
  end

  describe "append_owner_name" do
    it "concatenates the restaurant and owner names" do
      restaurant = FactoryBot.build_stubbed(:restaurant)

      result = restaurant.append_owner_name

      expect(result).to eq("Stella's by Stella Smith")
    end
  end

  describe "#has_address?" do
    context "when address is nil" do
      it "returns false" do
        restaurant = FactoryBot.build_stubbed(:restaurant)

        expect(restaurant).not_to have_address
      end
    end

    context "when address is not nil" do
      it "returns true" do
        restaurant = FactoryBot.build_stubbed(:restaurant, :with_address)

        expect(restaurant).to have_address
      end
    end
  end

  describe "#size" do
    context "when the restaurant can fit less than 20 people" do
      it "returns small" do
        restaurant = FactoryBot.build_stubbed(:restaurant, max_capacity: 19)
        result = restaurant.size

        expect(result).to eq("small")
      end
    end

    context "when the restaurant can fit less than 50 people" do
      it "returns medium" do
        restaurant = FactoryBot.build_stubbed(:restaurant, max_capacity: 20)

        result = restaurant.size

        expect(result).to eq("medium")
      end
    end

    context "when the restaurant can fit 50 or more people" do
      it "returns large" do
        restaurant = FactoryBot.build_stubbed(:restaurant, max_capacity: 50)

        result = restaurant.size

        expect(result).to eq("large")
      end
    end
  end
end
