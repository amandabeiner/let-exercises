require "spec_helper"
require "restaurant"
require "restaurant_owner"

RSpec.describe Restaurant do
  let(:address) { nil }
  let(:max_capacity) { 5 }
  let(:restaurant) { FactoryBot.build_stubbed(
    :restaurant,
    address: address,
    max_capacity: max_capacity
  ) }

  describe "#come_find_us" do
    context "when the address is nil" do
      it "returns a no set address message" do
        result = restaurant.come_find_us

        expect(result).to eq("View our schedule online")
      end
    end

    context "when the address is not nil" do
      let(:address) { "123 Main Street, Boston, MA 02122" }

      it "returns the atenated address" do
        result = restaurant.come_find_us

        expect(result)
          .to eq( "Come find us at 123 Main Street, Boston, MA 02122")
      end
    end
  end

  describe "append_owner_name" do
    it "concatenates the restaurant and owner names" do
      result = restaurant.append_owner_name

      expect(result).to eq("Stella's by Stella Smith")
    end
  end

  describe "#has_address?" do
    context "when address is nil" do
      it "returns false" do
        expect(restaurant).not_to have_address
      end
    end

    context "when address is not nil" do
      let(:address) { "123 Main St" }
      it "returns true" do
        expect(restaurant).to have_address
      end
    end
  end

  describe "#size" do
    context "when the restaurant can fit less than 20 people" do
      let(:max_capacity) { 19 }

      it "returns small" do
        result = restaurant.size

        expect(result).to eq("small")
      end
    end

    context "when the restaurant can fit less than 50 people" do
      let(:max_capacity) { 20 }

      it "returns medium" do
        result = restaurant.size

        expect(result).to eq("medium")
      end
    end

    context "when the restaurant can fit 50 or more people" do
      let(:max_capacity) { 50 }

      it "returns large" do
        result = restaurant.size

        expect(result).to eq("large")
      end
    end
  end
end
