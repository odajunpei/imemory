module ApplicationHelper
  
  def add_ress(address)
    address.insert(3, "-")
  end
  
end
