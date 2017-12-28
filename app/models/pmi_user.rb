class PmiUser < ApplicationRecord
  validates :name, :city, :country, :credential, :status, :earned, presence: true
end
