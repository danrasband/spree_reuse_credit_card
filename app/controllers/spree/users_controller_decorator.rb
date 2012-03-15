require 'card_reuse'

Spree::UsersController.class_eval do
  include CardReuse
  helper 'spree/admin/navigation'

  before_filter :load_existing_cards, :only => :show

  private

  def load_existing_cards
    @cards = all_cards_for_user(@user)
  end
end
