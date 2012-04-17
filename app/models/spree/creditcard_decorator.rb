Spree::Creditcard.class_eval do
  belongs_to :user
  belongs_to :address

  def deleted?
    !!deleted_at
  end

	def to_s
    string = "************#{last_digits} #{month}/#{year}"
    if address.present?
      string += " - #{address.to_plaintext}"
    end
  end
end
