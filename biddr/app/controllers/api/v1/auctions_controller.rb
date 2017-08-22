class Api::V1::AuctionsController < Api::BaseController
  before_action :authenticate_user!
  before_action :find_auction, only: [:show]

  def create
    auction = Auction.new(auction_params)
    auction.user = current_user

    if auction.save
      render json: { id: auction.id }
    else
      render json: { error: auction.errors.full_messages }
    end
  end

  def show
    # render json: current_user
    render json: @auction
  end

  def index
  	@auctions = Auction.all
  	render json: @auctions
  end

  def destroy
    if @auction.destroy
      head :ok
    else
      head :bad_request
    end
  end

  def update

  end

  def find_auction
    @auction = Auction.find(params[:id])
  end

end
