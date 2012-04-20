class Spree::CreditcardsController < Spree::BaseController
  #load_and_authorize_resource

  before_filter :load_address, :only => [:new, :create]
  before_filter :load_payment_methods, :only => :new

  respond_to :json, :only => :destroy
  respond_to :html, :except => [ :destroy ]

  def create

    # Set defaults
    @creditcard ||= Spree::Creditcard.new
    @payment_method = payment_method

    if @address.update_attributes(address_attributes)
      # Create new credit card - include payment method id and billing address
      if @creditcard.update_attributes(creditcard_attributes)
        @creditcard.address_id = @address.id
        @creditcard.user_id = current_user.id
        @creditcard.first_name = @address.firstname
        @creditcard.last_name = @address.lastname
        @creditcard.save
        # Use payment method to create profile
        if (@payment_method.respond_to?(:create_profile_from_card))
          @payment_method.create_profile_from_card(@creditcard)
        else
          @error = t(:unable_to_create_payment_profile)
          # Destroy address and credit card if unable to create a profile!
          @address.destroy
          @creditcard.destroy
        end
      else
        @error = t(:unable_to_save_credit_card)
        # Destroy the address if unable to save the credit card
        @address.destroy
      end
    else
      @error = t(:unable_to_save_address)
    end
    if @error.present?
      flash[:error] = @error
    else
      flash[:notice] = t(:payment_profile_saved_successfully)
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
        format.json { render :nothing => true, :status => 500 }
      end
    end
  end

  private
    def load_address
      @address ||= Spree::Address.default
    end

    def load_payment_methods
      @payment_methods = Spree::PaymentMethod.available(:front_end).select {
        |p| p.payment_profiles_supported? && p.payment_source_class.name == "Spree::Creditcard"
      }
    end

    def address_attributes
      @address_attributes ||= params[:payment_profile_source][payment_method.id.to_s.to_sym].delete(:billing_address)
    end

    def creditcard_attributes
      @creditcard_attributes ||= params[:payment_profile_source][payment_method.id.to_s.to_sym]
    end

    def payment_method
      if @payment_method.nil?
        begin
          @payment_method = Spree::PaymentMethod.find(params[:payment_profiles_attributes].first[:payment_method_id])
        rescue
          flash[:error] = t(:unkown_payment_method)
          redirect_back_or_default(account_path)
        end
      end
      @payment_method
    end
end
