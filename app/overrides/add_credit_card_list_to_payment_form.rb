Deface::Override.new(
  :name => 'add_credit_card_list_to_payment_form',
  :virtual_path => 'spree/checkout/payment/_gateway',
  :insert_before => '[data-hook=card_number]',
  :partial =>'spree/checkout/payment/existing_cards',
  :original => '558fa40b7734e939d98c3ba576aea1adc4f0ce00',
  :disabled => false,
)
