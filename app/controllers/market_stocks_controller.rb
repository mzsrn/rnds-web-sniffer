class MarketStocksController < ApplicationController

  def index
    #TODO Delegate fetch data to worker, take persistent data
    path = Rails.root.join('tmp/figi.json')
    @stocks = JSON.load(File.open(path))["payload"]["instruments"].first(10)
  end

end
