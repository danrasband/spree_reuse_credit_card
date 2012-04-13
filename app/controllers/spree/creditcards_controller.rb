class Spree::CreditcardsController < Spree::BaseController

  respond_to :json, :only => :destroy
  respond_to :html, :except => [ :destroy ]

  def new
    @address = Spree::Address.default
  end

  def create
    @creditcard = Spree::Creditcard.new
    @address = Spree::Address.default
    if params[:creditcard][:address].present?
      address_params = params[:creditcard].delete(:address)
      if @address.update_attributes(address_params)
        @creditcard.address = @address
        @creditcard.first_name = @address.firstname
        @creditcard.last_name = @address.lastname
        if @creditcard.update_attributes(params[:creditcard])
          flash[:notice] = t(:successfully_updated)
        else
          flash[:error] = t(:unsuccessfully_updated)
          @address.destroy
          redirect_to :back
          return
        end
      else
        flash[:error] = t(:unsuccessfully_updated)
        redirect_to new_creditcard_path
        return
      end
    end
    redirect_back_or_default(account_path)
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
