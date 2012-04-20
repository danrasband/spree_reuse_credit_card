Spree::Admin::NavigationHelper.module_eval do
  # This is a bug fix for spree... Shouldn't have to do this...
  def spree_dom_id(record)
    dom_id(record, 'spree')
  end
end
