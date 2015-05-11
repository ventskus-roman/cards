class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :check_original_and_translated_not_equals

  before_validation :set_default_review_date, :strip_whitespaces, on: :create

  scope :need_to_review, -> { where("review_date <= ?", Time.zone.now ).order("RANDOM()")}

  def check_original_and_translated_not_equals
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:translated_text, "can`t be the same as original text")
    end
  end

  def check_translation(text)
    if original_text.mb_chars.downcase.strip == text.mb_chars.downcase.strip
      update_review_date
    end
  end

  def update_review_date
    set_default_review_date
    save
  end

  private

  def strip_whitespaces
    original_text = original_text.strip
    translated_text = translated_text.strip
  end

  private

  def set_default_review_date
    review_date = 3.days.from_now
  end

end