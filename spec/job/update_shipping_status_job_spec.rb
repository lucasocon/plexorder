require 'rails_helper'

RSpec.describe UpdateShippingStatusJob, type: :job do
  include ActiveJob::TestHelper

  describe "Verify ActiveJob is working" do
    subject(:job) { described_class.perform_later }

    it 'queues the job' do
      expect { job }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it "matches with enqueued job" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        job
      }.to have_enqueued_job.on_queue("default")
    end

    describe "execute perform" do
      let(:product) { FactoryBot.create(:product)}

      before do
        @order_1 = FactoryBot.create(:order, product_id: product.id)
        @order_2 = FactoryBot.create(:order, product_id: product.id)
      end

      before do
        perform_enqueued_jobs { job }
        @order_1.reload
        @order_2.reload
      end

      it 'check initial order 1 status' do
        expect([
          'processing',
          'awaiting_pickup',
          'in_transit',
          'out_for_delivery',
          'delivered'
        ]).to include(@order_1.status)
      end

      it 'check initial order 2 status' do
        expect([
          'processing',
          'awaiting_pickup',
          'in_transit',
          'out_for_delivery',
          'delivered'
        ]).to include(@order_2.status)
      end

      it 'check initial order 1 fedex_id' do
        expect(@order_1.fedex_id).to eq "5"
      end

      it 'check initial order 2 fedex_id' do
        expect(@order_2.fedex_id).to eq "8"
      end

      it 'check initial order 1 status' do
        expect([
          'processing',
          'awaiting_pickup',
          'in_transit',
          'out_for_delivery',
          'delivered'
        ]).to include(@order_1.status)
      end

      it 'check initial order 2 status' do
        expect([
          'processing',
          'awaiting_pickup',
          'in_transit',
          'out_for_delivery',
          'delivered'
        ]).to include(@order_2.status)
      end

      it 'check initial order 1 fedex_id' do
        expect(@order_1.fedex_id).to eq "13"
      end

      it 'check initial order 2 fedex_id' do
        expect(@order_2.fedex_id).to eq "16"
      end
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end

  end
end
