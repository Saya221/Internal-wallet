# frozen_string_literal: true

module Api
  module LatestStockPrice
    class Adapter
      def initialize(args = {})
        @args = args.deep_symbolize_keys!
        @action = args[:action]
        @query = args[:query] || {}
        @body = args[:body] || {}
      end

      def execute
        @response = HTTParty.send(action, endpoint, query:, headers:, body:)

        success? ? success_response : failed_response
      end

      def success?
        response.code.in?(RAPIDAPI::SUCCESS_CODE)
      end

      private

      attr_reader :args, :action, :query, :body, :response

      def endpoint
        @endpoint ||= if args[:endpoint].in?(RAPIDAPI::ENDPOINTS.constants)
                        RAPIDAPI::ENDPOINTS.const_get(args[:endpoint])
                      else
                        @query = { Indices: RAPIDAPI::DEFAULT::INDICES }
                        RAPIDAPI::ENDPOINTS::PRICE
                      end
      end

      def headers
        {
          "X-RapidAPI-Key": ENV.fetch("RAPIDAPI_KEY", nil),
          "X-RapidAPI-Host": RAPIDAPI::HOST
        }
      end

      def success_response
        {
          code: response.code,
          success: true,
          data: {
            indices: response.parsed_response
          },
          meta: {}
        }
      end

      def failed_response
        {
          code: response.code,
          success: false,
          error: error
        }
      end

      def error
        {
          resource: response.with_indifferent_access[:link],
          field: nil,
          code: response.with_indifferent_access[:error_code],
          message: response.with_indifferent_access[:error]
        }
      end
    end
  end
end
