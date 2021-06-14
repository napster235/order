require "rails_helper"

RSpec.describe "Flowers", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  before :each do
    sign_in user
  end

  describe "#index" do
    let(:url) { flowers_path }
    let!(:flowers) { FactoryBot.create_list(:flower, 5, user_id: user.id) }

    subject { get url }

    context "a call to list flowers" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "loads the flowers from the database" do
        subject
        expect(assigns[:flowers].size).to eql(Flower.count)
      end
    end
  end

  describe "#new" do
    let(:url) { new_flower_path }

    subject { get url }

    context "a call to render a new flower form" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "loads the new record" do
        subject

        expect(assigns(:flower).new_record?).to eql(true)
      end
    end
  end

  describe "#create" do
    let(:url) { flowers_path }
    let(:params) { { flower: FactoryBot.attributes_for(:flower) } }

    subject { post url, params: params }

    context "a call to create a new flower" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "persists the record" do
        expect { subject }.to change { Flower.count }.by(1)
      end

      it "flashes the success notification" do
        subject

        expect(flash[:notice]).to eql("Flower successfully saved")
      end
    end

    context "a call to create an invalid flower" do
      subject { post url, params: { flower: { name: nil } } }

      it "responds with a stauts of ok (200)" do
        expect(subject).to eql(200)
      end

      it "does not persist the record" do
        expect { subject }.not_to change { Flower.count }
      end

      it "flashes the error message notification" do
        subject

        expect(flash[:alert]).to eql("Flower could not be saved")
      end
    end
  end

  describe "#edit" do
    let!(:flowers) { FactoryBot.create(:flower) }
    let(:url) { edit_flower_path(id: flowers.id) }

    subject { get url }

    context "a call to show the edit form for an existing flower" do
      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it " loads the correct record" do
        subject

        expect(assigns(:flower).id).to eql(flowers.id)
      end
    end

    context "a call to show the edit form for an inexisting flower" do
      let(:url) { edit_flower_path(id: 0) }

      subject { get url }

      it "responds with a status ok redirect (302)" do
        expect(subject).to eql(302)
      end
    end
  end

  describe "#update" do
    let(:url) { flower_path(id: flower.id) }
    let(:updated_flower_name) { "Flower_updated" }
    let(:flower) { FactoryBot.create(:flower) }

    subject { put url, params: { flower: { name: updated_flower_name } } }

    context "a call to update a flower" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "updates the attributes" do
        expect(flower.name).to_not eql(updated_flower_name)
        expect { subject }.to change { flower.reload.name }.to(updated_flower_name)
        subject
        expect(flower.reload.name).to eql(updated_flower_name)
      end

      it "flashes a success message notification" do
        subject

        expect(flash[:notice]).to eql("Flower successfully updated")
      end
    end

    context "a call to update a flower with an invalid attribute" do
      let(:invalid_attribute) { { flower: { name: nil } } }

      subject { put url, params: invalid_attribute }

      it "responds with a status of ok (200)" do
        expect(subject).to eql(200)
      end

      it "does not persist the record" do
        expect { subject }.not_to change { flower.name }
      end

      it "flashes an error message notification" do
        subject

        expect(flash[:alert]).to eql("Flower could not be updated")
      end
    end
  end

  describe "#destroy" do
    let!(:flower) { FactoryBot.create(:flower) }
    let(:url) { flower_path(id: flower.id) }

    subject { delete url }

    context "a call to delete a flower" do
      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "deletes the record" do
        expect { subject }.to change { Flower.count }.by(-1)
      end

      it "flashes a success message notification" do
        subject

        expect(flash[:notice]).to eql("Flower was deleted")
      end
    end

    context "a call to delete an invalid flower" do
      before :each do
        allow_any_instance_of(Flower).to receive(:destroy).and_return(false)
      end

      it "responds with a status of redirect (302)" do
        expect(subject).to eql(302)
      end

      it "does not delete the record" do
        expect { subject }.not_to change { Flower.where(id: flower.id).size }
      end

      it "flashes an error message notification" do
        subject

        expect(flash[:alert]).to eql("Flower was not deleted")
      end
    end
  end
end
