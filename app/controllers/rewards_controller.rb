class RewardsController < ApplicationController

  def index
    @user_rewards = current_user.rewards
  end

  def show
    @reward = Reward.find(params[:id])
  end
end
