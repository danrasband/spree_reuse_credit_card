require 'spec_helper'

describe Spree::CreditcardsController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  # let(:admin_user) { FactoryGirl.create(:admin_user) }

  context '#new' do

    context 'not logged in' do

      it 'should redirect to login page' do
        spree_get :new
        response.should redirect_to(spree.login_path)
      end

    end

    context 'logged in' do
      before { login_as user, :scope => :user }

      context 'no valid payment methods enabled' do

        it 'should display error message' do
          visit spree.new_creditcard_path
          page.should have_content('No payment methods are enabled. Please contact the website administrator.')
          response.should render_template('spree/users/show')
        end

      end

      context 'valid payment methods enabled' do
        let(:gateway) { mock_model(Spree::Gateway::AuthorizeNetCim) }
        let(:payment_method) { FactoryGirl.create(:payment_method) }
        let(:address) { FactoryGirl.create(:address) }
        before {
          @address = Spree::Address.default
          payment_method.type = 'Spree::Gateway::AuthorizeNetCim'
          payment_method.save
          address.user_id = user.id
          address.save
        }

        it 'should show error when required fields are empty'

        it 'should validate some data'

        it 'should show error when gateway is unavailable'

        it 'should show error when gateway returns error'

        it 'should allow user to create new credit card profile' do
          # @todo Should I make this more of an integration test???
          spree_get :new
          response.should render_template(:new)
          fake_response = stub(true)
          Spree::Gateway::AuthorizeNetCim.any_instance.should_receive(:create_profile_from_card).and_return(fake_response)

          spree_post :create, {
            :payment_profiles_attributes => [
              :payment_method_id => payment_method.id
            ],
            :payment_profile_source => {
              payment_method.id.to_s.to_sym => {
                :number => '4111111111111111',
                :month => '1',
                :year => (Date.new().year + 1).to_s,
                :verification_value => '123',
                :billing_address => {
                  :firstname => address.firstname,
                  :lastname => address.lastname,
                  :address1 => address.address1,
                  :address2 => address.address2,
                  :city => address.city,
                  :country_id => address.country_id,
                  :state_id => address.state_id,
                  :zipcode => address.zipcode,
                  :phone => address.phone
                }
              }
            }
          }

          response.should redirect_to(spree.account_path)
          puts page.to_s
        end

      end

    end

  end

  context '#destroy' do
  end

end
