class AuctionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_auction, only: [:edit, :destroy, :show, :update]
  before_action :authorize_user!, only: [:create, :show, :index, :destroy, :update]

  def index
    @auctions = Auction.viewable

    respond_to do |format|
      format.html { render }
      format.json { render json: @auctions }
      format.xml { render xml: @auctions }
    end
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      flash[:notice] = "Item created successfully!"
      redirect_to @auction
    else
      flash[:alert] = "Problem creating your item"
      render :new
  end

  def show
    @bid = Bid.new
  end

  def index
    @auction = Auction.order(id: :desc).limit(10)
  end

  def destroy
    if can? :destroy, @auction
      @auction.destroy
      flah[:notice] = "Item successfully deleted"
      redirect_to auction_path
    else
      flash[:alert] = "Access Denied. You can't delete an item that is not yours"
      redirect_to @auction
    end
  end

  def edit
    unless can? :edit, @auction
      flash[:alert] = "Access denied. You can't edit an item that is not yours"
      redirect_to root_path
    end
  end

  def update
    if cannot? :edit, @auction
      flash[:alert] = "Access Denied. You can't edit an item that is not yours"
      redirect_to @auction
    elsif @auction.update(auction_params)
      flash[:notice] = "Item updated successfully"
      redirect_to auction_path(@auction)
    else
      flash[:alert] = "Please fix errors"
      render :edit
    end
  end

  private
  def auction_params
    params.require(:auction).permit(:title, :details, :end_date, :price)
  end

  def find_auction
    @auction = Auction.find params[:id]
  end

  def authorize_user!
    unless can?(:manage, @auction)
      head :unauthorized
    end
  end
end
