class HomeController < ApplicationController
  def index
    @card = Card.random_need_to_review
    render 'random_card'
  end
end
