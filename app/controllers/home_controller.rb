class HomeController < ApplicationController
  def index
    @card = Card.need_to_review.first
    render 'random_card'
  end
end
