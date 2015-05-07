class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :check_original_and_translated_not_equals

  before_validation(on: :create) do
    self.review_date = 3.days.from_now
  end

  def check_original_and_translated_not_equals
    if original_text.downcase == translated_text.downcase
      errors.add(:translated_text, "can`t be the same as original text")
    end
  end

end