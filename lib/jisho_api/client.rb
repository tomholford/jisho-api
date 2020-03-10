require 'faraday'

module JishoAPI
  class APIError < StandardError; end

  class Client
    attr_accessor :response

    URI = 'https://jisho.org/api/v1/search/words'.freeze

    def initialize; end

    def make_request(params: {})
      params.merge!(keyword: query) unless params.key?(:keyword)
      params.merge!(page: page) unless params.key?(:page)

      self.response = connection.get do |req|
        req.params = params
      end

      handle_response
    end

    private

    def connection
      @connection ||= Faraday.new(
        url: URI,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def handle_response
      if response.status == 200 && api_status == 200
        api_data
      else
        raise APIError, "#{response.status} response from API"
      end
    end

    def api_status
      parsed_response[:meta][:status]
    end

    def api_data
      parsed_response[:data]
    end

    def parsed_response
      @parsed_response ||= JSON.parse(response.body).with_indifferent_access
    end
  end
end
