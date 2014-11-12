class SubscriptionsController < ApplicationController
  before_action :signed_in_user

  def update
  	if current_user.subscription.subscribed?(current_user)
    	current_user.subscription.unsubscribe(current_user)
    else
    	current_user.subscription.subscribe(current_user)
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
  	end
  end
  
end
