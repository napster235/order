require "rails_helper"

RSpec.describe "Orders", type: :request do
  describe "index" do
    let(:url) { orders_path }
    let!(:orders) { FactoryBot.create_list(:order, 5) }

    subject { get url }

    context "a call to list orders" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end
    end
  end

  describe "new" do
    let(:url) { new_order_path }

    subject { get url }

    context "a call to render a new order form" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end
    end
  end
end
