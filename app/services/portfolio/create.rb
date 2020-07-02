class Portfolio::Create < ActiveInteraction::Base

  object :user, class: User
  object :params, class: ActionController::Parameters

  def execute
    # TODO add_error(:base, "Invalid broker") unless %w(finam tinkoff).include? broker
    # TODO separate to classes
    if broker == "tinkoff"
      collar = Collar::Tinkoff.new(user, credentials)
      bobik = Bobik::Tinkoff.new(collar)
      selected_account = account || bobik.get_accounts[0]
      if selected_account.nil?
        add_error(:base, "Account not found")
        return
      else
        portfolio_data = bobik.get_portfolio(account || bobik.get_accounts[0])
      end
    else
      CallBobikJob.perform_now(user.id, credentials)
      return { status: "ok" }
    end
  rescue StandardError => e
    add_error e
  end

  private

  def broker
    params.require(:broker)
  end

  def credentials
    params.require(:credentials)
  end

  def account
    params[:account].presence
  end

end