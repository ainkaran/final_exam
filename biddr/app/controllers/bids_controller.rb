class BidsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_bid, only: [:destroy]
  before_action :authorize_user!, only: [:create, :destroy]

  def create
    @auction = Auction.find params[:id]
    @bid = @auction.bids.build(bid_params)
    @bid.user = current_user

    if @bid.save
      redirect_to auction_path(@auction)
    else
      @bids = @auction.bids.order(created_at: :desc)
      render 'auctions/show'
    end
  end

  def destroy
    if can?(:destroy, @bid)
      @bid.destroy
      redirect_to auction_path(params[:auction_id]), notice: 'Bid Deleted'
    else
      redirect_to auction_path(params[:auction_id]), alert:'Bid NOT Deleted'
  end

  private
  def find_bid
    @bid = Bid.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @bid)
      head :unauthorized
    end
  end
end
