class StaticController < ApplicationController
  def home
  end


  def search
    payload = { query: params["q"], page: params["page"], per_page: params["per_page"], order: params["sort_by"] }
    @repositories = GithubApi.new(payload).call
    total_pages = (@repositories["total_count"]/params["per_page"]) rescue 0
    render json: { repositories: @repositories["items"], total_count: @repositories["total_count"], total_pages: total_pages }, status: :ok
  end
end
