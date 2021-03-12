require "rails_helper"


RSpec.describe "Api::V1::Rss", type: :request do
    let(:rss){ create(:rss) }
    describe "GET /api/v1/rss" do
        before { rss }

        it "returns json response" do
            get api_v1_rss_path
      
            expect(response.media_type).to eq("application/json")
            expect(response).to have_http_status(:ok)
        end

        it "returns correct attributes for an rss", :aggregate_failures do
            get api_v1_rss_path

            response_rss = response.parsed_body.first
            expect(response_rss.keys).to match_array(%w[ id original_url description title img_url generated_url isready created_at updated_at])
            
            # %w[id original_url title].each do |attr|
            #   expect(response_rss[attr]).to eq(podcast_episode.public_send(attr))
            # end
            # expect(response_rss["image_url"]).to eq(podcast_episode.podcast.image_url)
        end
    end

    describe "POST /api/v1/rss/" do
        before { rss }

        def post_rss(params)
            headers = { "content-type" => "application/json" }
            
            post "/api/v1/rss", params: { rss: params }.to_json, headers: headers
        end

        it "returns a error massege" do
            rss[:original_url] = nil
            post_rss(rss)            
            expect(response).to have_http_status(406)
            expect(response.parsed_body[0]["msg"]).to eq "The url is not avalid RSS"
        end
        
        it "returns a 201 after created" do
            new_rss = {
                original_url: "https://nypost.com/feed/"
            }
            post_rss(new_rss)
            
            expect(response).to have_http_status(:created)
            expect(Rss.count).to eq 2


            # expect(Client.last.name).to eq client_name
        end

        it "returns a 200 after find exist rss" do
            
            post_rss(rss)
            rss_exist = response.parsed_body[1]
            # puts "sdsd",response.parsed_body[1]
            expect(response).to have_http_status(:ok)
            expect(Rss.count).to eq 1
            expect(rss[:original_url]).to eq rss_exist["original_url"]

            # expect(Client.last.name).to eq client_name
        end




    end

end