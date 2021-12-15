class Destination < ApplicationRecord
    
  belongs_to :member
  
    validates :postal_code, :address, :name, presence: true
    
  def destinations_address
    '〒' + self.postal_code.insert(3, "-") + " " + self.address + " " + self.name
  end
    
end
