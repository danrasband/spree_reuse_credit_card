Spree::Address.class_eval do
  def to_plaintext
    "#{firstname} #{lastname}, #{address1} #{address2} #{city}, #{state || state_name} #{zipcode} #{country}".html_safe
  end
end
