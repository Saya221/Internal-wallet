# frozen_string_literal: true

class Api::V1::LatestStockPricesController <  Api::V1::BaseController
  skip_before_action :authenticate_request

  def price
    response = Api::LatestStockPrice::Adapter.new(action: :get, query: processing_query_params, endpoint: :PRICE).execute

    render_based_on(response)
  end

  def prices
    response = Api::LatestStockPrice::Adapter.new(action: :get, query: processing_query_params, endpoint: :PRICES).execute

    render_based_on(response)
  end

  def price_all
    response = Api::LatestStockPrice::Adapter.new(action: :get, endpoint: :PRICE_ALL).execute

    render_based_on(response)
  end

  private

  def processing_query_params
    raise ActionController::ParameterMissing, nil unless params[:indice]

    {
      Indices: params[:indice]
    }
  end

  def render_based_on(response)
    # TODO: Update error response.

    if response[:success]
      render_json response[:data], meta: response[:meta], status: response[:code]
    else
      render_json response[:error], success: response[:success], status: response[:code]
    end
  end
end
