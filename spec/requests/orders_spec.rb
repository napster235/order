require "rails_helper"

RSpec.describe "Orders", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before :each do
    sign_in user
  end

  describe "#index" do
    let(:url) { orders_path }
    let!(:orders) { FactoryBot.create_list(:order, 5) }

    subject { get url }

    context "a call to list orders" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "loads the orders from the database" do
        subject
        expect(assigns(:orders).size).to eql(Order.count)
      end
    end

    context "a call to filter order records" do
      let(:params) { { q: { search_query: Order.first.order_number } } }

      subject { get url, params: params }

      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "returns a list of gl accounts based on the filter" do
        subject

        expect(assigns(:orders).size).to eql(1)
      end
    end
  end

  describe "#new" do
    let(:url) { new_order_path }

    subject { get url }

    context "a call to render a new order form" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "loads the new record" do
        subject

        expect(assigns(:order).new_record?).to eql(true)
      end
    end
  end

  describe "#create" do
    let(:url) { orders_path }
    let(:params) { { order: FactoryBot.attributes_for(:order) } }

    subject { post url, params: params }

    context "a call to create a new order" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "persists the record" do
        expect { subject }.to change { Order.count }.by(1)
      end

      it "flashes the success message notification" do
        subject

        expect(flash[:notice]).to eql("Order successfully saved")
      end
    end

    context "a call to create an invalid order" do
      subject { post url, params: { order: { order_number: nil } } }

      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "does not persist the record" do
        expect { subject }.not_to change { Order.count }
      end

      it "flashes the error message notification" do
        subject

        expect(flash[:alert]).to eql("Order could not be saved")
      end
    end
  end

  describe "#edit" do
    let!(:orders) { FactoryBot.create(:order) }
    let(:url) { edit_order_path(id: orders.id) }

    subject { get url }

    context "a call to show the edit form for an existing order" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "loads the correct record" do
        subject

        expect(assigns(:order).id).to eql(orders.id)
      end
    end

    context "a call to show the edit form for an inexisting order" do
      let(:url) { edit_order_path(id: 0) }

      subject { get url }

      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end
    end
  end

  describe "#update" do
    let(:url) { order_path(id: order.id) }
    let(:updated_order_number) { "Order_updated" }
    let(:order) { FactoryBot.create(:order) }

    subject { put url, params: { order: { order_number: updated_order_number } } }

    context "a call to update an order" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "updates the attributes" do
        expect(order.order_number).to_not eql(updated_order_number)
        expect { subject }.to change { order.reload.order_number }.to(updated_order_number)
        subject
        expect(order.reload.order_number).to eql(updated_order_number)
      end

      it "flashes a success message notification" do
        subject

        expect(flash[:notice]).to eql("Order successfully updated")
      end
    end

    context "a call to update an order with an invalid attribute" do
      let(:invalid_attribute) { { order: { order_number: nil } } }

      subject { put url, params: invalid_attribute }

      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "does not persist the record" do
        expect { subject }.not_to change { order.order_number }
      end

      it "flashes an error message notification" do
        subject

        expect(flash[:alert]).to eql("Order could not be updated")
      end
    end
  end

  describe "#destroy" do
    let!(:order) { FactoryBot.create(:order) }
    let(:url) { order_path(id: order.id) }

    subject { delete url }

    context "a call to delete an order" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "deletes the record" do
        expect { subject }.to change { Order.count }.by(-1)
      end

      it "flashes a success message notification" do
        subject

        expect(flash[:notice]).to eql("Order was deleted")
      end
    end

    context "a call to delete an invalid order" do
      before :each do
        allow_any_instance_of(Order).to receive(:destroy).and_return(false)
      end

      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "does not delete the record" do
        expect { subject }.not_to change { Order.where(id: order.id).size }
      end

      it "flashes an error message notification" do
        subject

        expect(flash[:alert]).to eql("Order was not deleted")
      end
    end
  end
end
