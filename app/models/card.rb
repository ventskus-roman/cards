class Card < ActiveRecord::Base
  validates :original_text, presence: true
  validates :translated_text, presence: true
  validates :review_date, presence: true
  validate :check_original_and_translated_not_equals

  def check_original_and_translated_not_equals
    if original_text.downcase == translated_text.downcase
      errors.add(:translated_text, "can`t be the same as original text")
    end
  end

end
