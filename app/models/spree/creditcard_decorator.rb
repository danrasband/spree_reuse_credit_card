Spree::Creditcard.class_eval do
  belongs_to :user
  belongs_to :address

  def deleted?
    !!deleted_at
  end

	def to_s
    "************#{last_digits} #{month}/#{year}"
  end
end
