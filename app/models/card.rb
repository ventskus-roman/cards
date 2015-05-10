class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :check_original_and_translated_not_equals

  before_validation :set_default_review_date, :strip_whitespaces, on: :create

  scope :random, -> { order("RANDOM()") }
  scope :need_to_review, -> { where("review_date <= ?", Time.zone.now )
                              .select(:id, :translated_text)}

  def check_original_and_translated_not_equals
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:translated_text, "can`t be the same as original text")
    end
  end

  def self.random_need_to_review
    random_card = need_to_review.random
    if (random.empty?)
      nil
    else
      random_card.first
    end
  end

  def update_review_date
    set_default_review_date
    self.save
  end

  private
    def strip_whitespaces
      self.original_text = self.original_text.strip
      self.translated_text = self.translated_text.strip
    end

  private
    def set_default_review_date
      self.review_date = 3.days.from_now
    end

end