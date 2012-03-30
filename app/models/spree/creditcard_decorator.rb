Spree::Creditcard.class_eval do
  def deleted?
    !!deleted_at
  end
	
	def to_s
    "************#{last_digits} #{month}/#{year}"
  end
end
