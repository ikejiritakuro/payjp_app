class UsersController < ApplicationController
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?

    customer = Payjp::Customer.retrieve(card.customer_token) 
    @card = customer.cards.first
  end

  def update
    if current_user.update(user_params)
      redirect_to action: "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
