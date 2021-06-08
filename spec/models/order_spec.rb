require "rails_helper"

RSpec.describe Order, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe "#save" do
    subject { order.save; order }

    context "when order_number is not nil" do
      let(:order) { FactoryBot.create(:order) }

      it "creates record" do
        expect { subject }.to change { Order.count }.by (1)
      end
    end

    context "when order_number is nil" do
      let(:order) { FactoryBot.build(:order, order_number: nil) }

      it "does not create record" do
        expect { subject }.to change { Order.count }.by (0)
      end
    end

    context "when order_number is not unique" do
      let(:order_number) { "Order_123456" }
      let!(:order1) { FactoryBot.create(:order, order_number: order_number) }
      let(:order) { FactoryBot.build(:order, order_number: order_number) }

      it "does not create record" do
        expect { subject }.not_to change { Order.count }
      end

      it "returns error messages" do
        subject

        expect(order.errors.full_messages).to eql(["Order number has already been taken"])
      end
    end

    context "when order_number is unique" do
      let(:order_number) { "Order_123456" }
      let(:order) { FactoryBot.create(:order, order_number: order_number) }

      it "creates records" do
        expect { subject }.to change { Order.count }.by (1)
      end

      it "saves order_number" do
        subject

        expect(order.reload.order_number).to eql(order_number)
      end
    end

    context "when order_number is shorter than 6 chars" do
      let(:order_number) { "Ord" }
      let(:order) { FactoryBot.build(:order, order_number: order_number) }

      it "doesn not create the record" do
        expect { subject }.not_to change { Order.count }
      end

      it "returns error messages" do
        subject

        expect(order.errors.full_messages).to eql(["Order number is too short (minimum is 6 characters)"])
      end
    end

    context "when user_id is nil" do
      let(:order) { FactoryBot.build(:order, user_id: nil) }

      it "does not create record" do
        expect { subject }.not_to change { Order.count }
      end
    end

    context "when status is nil" do
      let(:order) { FactoryBot.build(:order, status: nil) }

      it "does not create record" do
        expect { subject }.not_to change { Order.count }
      end
    end
  end

  describe "#destroy" do
    let(:order1) { FactoryBot.create(:order) }
    let(:order2) { FactoryBot.create(:order) }
    let(:order3) { FactoryBot.create(:order) }

    context "when destroying a record" do
      subject { order1.destroy }

      it "deleted the record" do
        subject

        expect(Order.find_by_id(order1.id)).not_to be_present
      end
    end
  end
end
