require 'rails_helper'

RSpec.describe Rss, type: :model do
  let(:rss) { create(:rss) }
  let(:rss_test) { Rss.create(original_url: 'https://www.politico.com/rss/politicopicks.xml') }        

  describe 'validation:' do
    context 'Validate title' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(255) }
    end

    context 'Validate original_url' do
      it { should validate_presence_of(:original_url) }
      it { should validate_length_of(:original_url).is_at_most(255) }
      it { should validate_uniqueness_of(:original_url) }
    end
  end

  describe '#rss_fetch' do
    it 'fires Fetch RSS method as after_create method callbacks' do
      expect(rss).to receive(:rss_fetch)
      rss.run_callbacks(:create)
    end
  end

  describe '#get_feed' do
    before do
     
    end

    it "return if rss nil" do
        rss = nil
        expect(Rss.get_feed(rss)).to eq(nil)
    end

    it "should create 'filename' and put 'article' in it" do
        Rss.get_feed(rss_test)
        expect(File.filename("#{Rails.root}/tmp/rss_files/aaa/")).to be true
    end

    # it "tagging should do something" do
    #     expect(tagging.something).to eq('something')
    # end

    end 
end
