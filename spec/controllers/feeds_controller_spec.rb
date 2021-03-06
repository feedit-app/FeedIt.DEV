require 'spec_helper'

RSpec.describe FeedsController, type: :controller do

  describe "GET index" do

    it "fails to render without XML format" do
      expect { get(:index) }.to raise_error(ActionController::UnknownFormat)
    end

    it "renders the base xml template" do
      get :index, format: :xml
      expect(response.content_type).to eq('application/xml')
      expect(response).to render_template(:index)
    end

    it "assigns the Feed with params to the @feed object correctly" do
      feed_mock = Feed.new({
        existing_feed: nil,
        episodes: 2,
        empty_guid: nil,
        duplicate_guid: nil
      }).generate!
      get :index, { params: { eps: "2"}, format: :xml }
      expect(assigns(:feed).episodes.count).to eq(feed_mock.episodes.count)
    end
  end
end
