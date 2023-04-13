class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys

    render ({ :template => "currency_templates/step_one.html.erb" })
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")

    @array_of_symbols = @symbols_hash.keys
    @currency_from = params.fetch("currency_from")

    render ({ :template => "currency_templates/step_two.html.erb" })
  end

  def third_currency
    @currency_from = params.fetch("currency_from")
    @currency_to = params.fetch("currency_to")

    @raw_conversion_data = open("https://api.exchangerate.host/convert?from=#{@currency_from}&to=#{@currency_to}").read
    @parsed_conversion_data = JSON.parse(@raw_conversion_data)
    @query_hash = @parsed_conversion_data.fetch("info")

    @amount_conversion = @query_hash.fetch("rate")

    render ({ :template => "currency_templates/step_three.html.erb" })
  end
end
