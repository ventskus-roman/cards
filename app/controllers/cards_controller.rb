class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card[:review_date] = 3.days.from_now
    if @card.save
      redirect_to :cards
    else
      render 'new'
    end
  end

  def destroy
    card = Card.find(params[:id])
    card.destroy

    redirect_to :cards
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to :cards
    else
      render 'edit'
    end
  end

  private
    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end
end
