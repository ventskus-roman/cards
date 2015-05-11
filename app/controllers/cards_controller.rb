class CardsController < ApplicationController
  before_action :find_card, only: [:edit, :update, :destroy, :check]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def check
    if @card.check_translation(check_card_params[:original_text])
      flash[:notice] = "Правильно"
      redirect_to root_path
    else
      flash.now[:error] = "Не правильно"
      render 'home/random_card'
    end
  end

  private

    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end

  private

  def find_card
    @card = Card.find(params[:id])
  end

  private
    def check_card_params
      params.require(:card_translation).permit(:original_text)
    end

end
