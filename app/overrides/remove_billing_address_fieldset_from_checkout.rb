# Billing address should be tied to the credit card.
# @todo Add billing address form to the "Other card" section of the payment
#   form.
Deface::Override.new(
  :name => 'remove_billing_address_fieldset_from_checkout',
  :virtual_path => 'spree/checkout/_address',
  :remove => '[data-hook="billing_fieldset_wrapper"]',
  :original => 'dbef69a5c0803c9ddb5aeb511b224bff99ffb26f',
)
