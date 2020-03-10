require 'json'
require 'active_support/core_ext/hash/indifferent_access'

require 'jisho_api/version'
require 'jisho_api/client'

module JishoAPI
  # Ruby gem for the unofficial Jisho API.
  class JishoAPI
    attr_accessor :page, :query

    def initialize(query: nil, page: 1, debug: false)
      @query = query
      @page = page
      require 'httplog' if debug
    end

    # Query using the query and page set initially, but can be overridden by passing in args.
    # @param query (string) Search the API for a given query.
    # @param page (integer) Which page to fetch; defaults to 1
    def search(query: nil, page: nil)
      query ||= self.query
      page ||= self.page

      client.make_request(params: { keyword: query, page: page })
    end

    # Fetches the next page of results, reusing the same query. Increments the internal page counter as a side effect.
    def next_page!
      self.page += 1

      client.make_request(params: { keyword: query, page: page })
    end

    # @param query (string) Search the API for a given query and fetches the first page of results;
    def self.search(query)
      new.search(query: query)
    end

    private

    def client
      @client ||= Client.new
    end
  end
end
