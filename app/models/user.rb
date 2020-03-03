# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_one :profile_picture, as: :imageable
  has_one_attached :profile_picture

  validates :name, presence: true

  def has_roles
    roles.pluck(:name).join(',')
  end
end
