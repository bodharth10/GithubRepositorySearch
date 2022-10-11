class GithubApi
  attr_accessor :page, :per_page

  include HTTParty
  base_uri "https://api.github.com/search"

  def initialize(options={}, autocomplete=false)
    @page = options[:page]
    @per_page = options[:per_page]
    @query = options[:query]
  end  

  def call
    begin
      Rails.logger.info("===================================")
        query = { q: @query, page: @page, per_page: @per_page, order: "desc" }
        headers = { 'Content-Type' => 'application/json', 'Authorization' => Rails.application.credentials.github[:access_token]}
        @response ||= self.class.get(end_point, query: query, headers: { 'Content-Type' => 'application/json', 'Authorization' => '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'})

        raise Retry if @response.code == 503 and options[:raise_errors]

      if @response.code == 200
        (@response)
      else
        {}
      end
    rescue => e
      raise
    rescue Exception => e
      Rails.logger.info("====================================================================")
      Rails.logger.debug("API Calling Error: #{end_point} ==== #{@options}")
      {}
    end
  end

  def end_point
    "/repositories"
  end
end
