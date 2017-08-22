class Auction < ApplicationRecord
  belongs_to :user

  has_many :bids

  validates :title, { presence: true, uniqueness: { case_sensitive: false } }

  validates(:details, { presence: true, length: { minimum: 5, maximum: 2000 }})

  validates :price, presence: true, numericality: {greater_than: 0}

  validate :price_is_valid_decimal_precision

  after_initialize :set_defaults

  before_save :capitalize_title
  before_destroy :destroy_notification

  def self.search(str)
    search_term = str
    where(["title ILIKE? OR details ILIKE?", "%#{search_term}%", "%#{search_term}%"]).order(:title, :details)
  end

  def self.recent(count)
    order({ created_at: :desc }).limit(count)
  end

  include AASM

  # DSL: Domain Specific Language, it's Ruby code written in a certain way that
  #      seems like it's own language to serve a purpose (in this case defining
  #      the state machine rules)
  aasm whiny_transitions: false do
    state(:draft, { initial: true })
    state :published
    state :reserve_met

    event :publish do
      transitions from: [:draft], to: :published
    end

    event :reserve do
      transitions from: [:published], to: :reserve_met
    end
  end

  def self.viewable
    where(aasm_state: [:published, :reserve_met, :draft]).order(created_at: :desc)
  end

  private

  def price_is_valid_decimal_precision
    if price.to_f != price.to_f.round(2)
      errors.add(:price, "The price of the item is invalid. There should only be two digits at most after the decimal point.")
    end
  end

  def set_defaults
    self.price ||= 1
  end

  def capitalize_title
    self.title = title.capitalize if title.present?
  end

  def destroy_notification
    Rails.logger.warn("The item #{self.title} is about to be deleted")
  end

end
