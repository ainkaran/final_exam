class Api::V1::BidsController < Api::BaseController
  before_action :authenticate_user!
  before_action :find_bid, only: [:show]

  def create
    bid = Bid.new(bid_params)
    bid.user = current_user

    if bid.save
      render json: { id: bid.id }
    else
      render json: { error: bid.errors.full_messages }
    end
  end

  def destroy
    if @bid.destroy
      head :ok
    else
      head :bad_request
    end
  end

  # def show
  #   # render json: current_user
  #   render json: @bid
  # end

  def index
  	@bids = Bid.all
  	render json: @bids
  end

  def find_bid
    @bid = Bid.find(params[:id])
  end

end
