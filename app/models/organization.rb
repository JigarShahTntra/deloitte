# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, :url, :address, presence: true
  validates :name, length: { maximum: 30 }
  validates :phone_number, presence: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :cin, uniqueness: { message: '^Organization CIN number has already been taken' }, presence: true
  # , length: { is: 21 }, format: { with: /[U,L]\d{5}[A-Z]{2}\d{4}[A-Z]{3}\d{6}/ }
  validates :pan, uniqueness: { message: '^Organization PAN number has already been taken' }, presence: true
  # , length: { is: 10, message: I18n.t('organization.must_be_10') }, format: { with: /[a-zA-Z]{5}\d{4}[a-zA-Z]{1}/ }
  validates :gst, uniqueness: { message: '^Organization GST number has already been taken' }, presence: true
  # , length: { is: 15 }, format: { with: /\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}/ }
  validates_uniqueness_of :name, message: '^Organization Name has already been taken'

  enum status: %w[unauthorized authorized]
  accepts_nested_attributes_for :users
end
