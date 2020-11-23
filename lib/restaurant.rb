class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :restaurant_owner

  def come_find_us
    if has_address?
      "Come find us at #{address}"
    else
      "View our schedule online"
    end
  end

  def append_owner_name
    "#{name} by #{restaurant_owner.name}"
  end

  def has_address?
    !address.nil?
  end
end
