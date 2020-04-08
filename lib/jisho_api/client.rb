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

      invalidate_cached_response!

      self.response = connection.get do |req|
        req.params = params
      end

      handle_response
    end

    private

    def connection
      @connection ||= Faraday.new(
        url: URI,
        headers: { 
          'Content-Type' => 'application/json',
          'User-Agent' => "gem jisho_api #{JishoAPI::VERSION}"
        }
      )
    end

    def handle_response
      return api_data if response.status == 200 && api_status == 200

      raise APIError, "#{response.status} response from API"
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

    def invalidate_cached_response!
      self.response = nil
      self.parsed_response = nil
    end
  end
end
