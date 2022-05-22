class Contact < ApplicationRecord
  belongs_to :user

  validates :name, :relationship, presence: true

  enum relationship: {
    personal: 0, 
    business: 1
  }
end
