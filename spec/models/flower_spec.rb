require 'rails_helper'

RSpec.describe Flower, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe "#save" do
    subject { flower.save; flower }

    context "when name is not nil" do
      let(:flower) { FactoryBot.create(:flower) }

      it "creates record" do
        expect { subject }.to change { Flower.count }.by(1)
      end
    end

    context "when name is nil" do
      let(:flower) { FactoryBot.build(:flower, name: nil) }

      it "does not create the record" do
        expect { subject }.to change { Flower.count }.by(0)
      end
    end

    context "when name is shorter than 3 characters" do
      let(:name) { "Fl" }
      let(:flower) { FactoryBot.build(:flower, name: name) }

      it "does not create the record" do
        expect { subject }.to change { Flower.count }.by(0)
      end
    end

    context "when price is nil" do
      let(:flower) { FactoryBot.build(:flower, price: nil) }

      it "does not create the record" do
        expect { subject }.to change { Flower.count }.by(0)
      end
    end

    context "when price is not integer" do
      let(:flower) { FactoryBot.build(:flower, price: "string") }

      it "does not create the record" do
        expect { subject }.to change { Flower.count }.by(0)
      end
    end
  end

  describe "#destroy" do
    let(:flower1) { FactoryBot.create(:flower) }
    let(:flower2) { FactoryBot.create(:flower) }
    let(:flower3) { FactoryBot.create(:flower) }

    context "when destroying a record" do
      subject { flower1.destroy }

      it "deleted the record" do
        subject

        expect(Flower.find_by_id(flower1.id)).not_to be_present
      end
    end
  end
end





























