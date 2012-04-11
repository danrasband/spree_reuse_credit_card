class Spree::CreditcardsController < Spree::BaseController

  respond_to :json, :only => :destroy
  respond_to :html, :except => [ :destroy ]

  def create
    @address = Spree::Address.new
  end

  def destroy
    @creditcard = Spree::Creditcard.find(params["id"])
    authorize! :destroy, @creditcard

    # TODO: think about the necessity of deleting payment profiles here.
    # I'm thinking we want to always leave them alone

    if @creditcard.update_attribute(:deleted_at, Time.now)
      respond_with(@creditcard) do |format|
        format.json { render :status => 200 }
      end
    else
      respond_with(@creditcard) do |format|
        format.json { render :status => 500 }
      end
    end
  end
end
