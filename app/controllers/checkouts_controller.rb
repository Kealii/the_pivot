class CheckoutsController < ApplicationController
  def new
    @address = Address.new
  end

  def confirm
  end

  def create
    @address = Address.new(address_params)
    current_user.address = @address
    @assistance = Assistance.new
  end

  private
  def address_params
    {full_name: params["full_name"],
      street1: params["street1"],
      street2: params["street2"],
      city: params["city"],
      state: params["state"],
      zip: params["zip"]
    }
  end

end
