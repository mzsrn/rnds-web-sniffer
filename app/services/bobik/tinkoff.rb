class Bobik::Tinkoff < Bobik::Base

  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize collar
    @token = collar.token
    super(collar)
    byebug
  end

  class << self
    def fetch_portfolio!
      portfolio_json = File.read(Rails.application.root + '/tmp/tinkoff/portfolio.json')
      JSON.parse portfolio_json
    end
  end

end