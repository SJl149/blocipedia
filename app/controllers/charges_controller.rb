class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Premium Membership - #{current_user.email}",
      currency: "usd"
    )

    current_user.update_attribute( :role, :premium)
    flash[:notice] = "#{current_user.email} is now Premium!"
    redirect_to authenticate_root_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def downgrade
    current_user.update_attribute( :role, :standard)
    if current_user.standard?
      flash[:notice] = "#{current_user.email} has been downgraded successfully."
      redirect_to authenticate_root_path(current_user)
    else
      flash.now[:alert] = "There was an error downgrading your account."
      redirect_to authenticate_root_path(current_user)
    end
  end
end
