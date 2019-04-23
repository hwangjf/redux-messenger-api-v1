class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

  has_many :participants
  has_many :users, through: :participants
end
